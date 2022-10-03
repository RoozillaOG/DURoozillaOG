# param(
#   [Parameter(Mandatory=$true)][string]$LuaFile,
#   [string]$OutputFile,
#   [switch]$CopyToClipboard)
class CodeFile {
  [int]$HandlerKey
  [string]$FileName
  [hashtable]$Requires = @{}
  [string[]]$Code

  CodeFile(
    [PSObject]$PB,
    [PSObject]$Handler)
  {
    $slot = $($handler.filter.slotKey)
    $slotName = $($PB.slots.$slot.name)
    $this.HandlerKey = $handler.key
    $this.FileName = @(
      $slotName,
      ($handler.filter.signature -replace "\(|\)","_"),
      $handler.key,
      "lua"
    ) -join "."

    $this.Code = $Handler.Code
  }

  CodeFile(
    [string]$Path)
  {
    $this.FileName = $Path
    $this.Code = (Get-Content -Path $Path) -join "`n"
  }

  CodeFile() {}

  [void]Write(
    [bool]$Overwrite) 
  {
    $requiresFound = @()
    $parts = ($this.Code.Trim() -split "--== start file ")
    if($parts.Count -eq 1) {
      Write-Host "Creating new file $($this.FileName)"
      $this.Code.Trim() | Set-Content $this.FileName
      return
    }

    foreach($part in ($parts | Where-Object {$_ -ne ""})) {
      $allLines = ($part -join "`n" -split "--== end file")[0]
      if($allLines -match "(?<path>.*?) ==--") {
        $lines = $allLines -split "\n" | Select-String -NotMatch " ==--"
        $cleanedCode = $lines -join "`n"
        $cleanedCode = $cleanedCode -replace "--==require","require"
        $requiresFound += Resolve-Path -Path $Matches.path -Relative
        Write-Host "Writing $($Matches.path)"
        Write-Host " - With relative path $($requiresFound[-1])"
        if((Test-Path -Path $requiresFound[-1]) -and ($Overwrite -eq $false)) {
          Write-Host " - Skipping write since Overwrite was not true"
        }
        else {
          $cleanedCode | Set-Content -Encoding Ascii -Path $requiresFound[-1]
        }
      }
    }

    # check if file was renamed
    if($this.CodeFile.FileName) {
      if((Get-Item $requiresFound[-1]).Name -ne (Get-Item $this.FileName).Name) {
        Move-Item $requiresFound[-1] $this.FileName
      }
    }
  }

  [void]GetRequires(
    [string]$Path)
  {
    $content = Get-Content $Path
    if($this.Requires.ContainsKey($Path)) {
      Write-Host "${Path} - Already processed"
      return
    }
    else {
      Write-Host "${Path} - Processing..."
    }

    $this.Requires[$Path] = ((Get-Content -Path $Path) -join "`n").Trim() -split "`n"

    $currentReq = $content | Select-String "^require `".*\.lua`""
    foreach($req in $currentReq) {
      if($req -match "^require `"(?<path>.*\.lua)`"") 
      {
        $reqPath = $Matches.path
        if($Matches.path.Contains("Mock")) {
          $this.Requires[$Path] = $this.Requires[$Path] -join "`n" -replace "require `"${reqPath}`"", "--==require `"${reqPath}`"" -split "`n"
        }
        else {
          $this.Requires[$Path] = $this.Requires[$Path] -join "`n" -replace "require `"${reqPath}`"", "--==require `"${reqPath}`"" -split "`n"
          $relativePath = Resolve-Path -Relative "$(Split-Path -Parent $Path)/${reqPath}"
          $this.GetRequires($relativePath) 
        }
      }
    }
  }

  [void]Read()
  {
    $this.FileName = (Resolve-Path -Relative $this.FileName)
    $this.GetRequires($this.FileName)

    # move this require to Code
    $this.Code = $this.Requires[$this.FileName]
    $this.Requires.Remove($this.FileName)
  }
}

class DisplayFile {
  [string]$Code = ""
  [CodeFile]$CodeFile
  
  DisplayFile()
  {

  }

  DisplayFile(
    [string]$Path)
  {
    $this.CodeFile = [CodeFile]::new($Path)
    $this.CodeFile.Read()
    $this.Parse()
  }

  static [DisplayFile]FromFile(
    [string]$Path)
  {
    return [DisplayFile]::FromString(((Get-Content -Path $Path) -join "`n"))
  }

  static [DisplayFile]FromString(
    [string]$Data)
  {
    $df = [DisplayFile]::new()
    $df.CodeFile = [CodeFile]::new()
    $df.CodeFile.Code = $Data
    return $df
  }

  [void]Write(
    [bool]$Overwrite)
  {
    $this.CodeFile.Write($Overwrite)
  }

  [void]Parse()
  {
    $unitFileHeader = ""
    foreach($req in $this.CodeFile.Requires.Keys)
    {
        $unitFileHeader += @"

--== start file ${req} ==--

$($this.CodeFile.Requires[$req] -join "`n")

--== end file ${req} ==--

"@
    }

    $this.Code = @"

$unitFileHeader

--== start file $($this.CodeFile.FileName) ==--

$($this.CodeFile.Code -join "`n")

--== end file $($this.CodeFile.FileName) ==--

"@
  }
}

class PBFile {
  [PSObject]$PBContents
  [CodeFile[]]$SlotFiles

  static [PBFile]FromFile(
    [string]$Path)
  {
    return [PBFile]::FromString((Get-Content -Path $Path))
  }

  static [PbFile]FromString(
    [string]$Data)
  {
    $pbFile = [PBFile]::new()
    $pb = ($Data) | ConvertFrom-Json
    $pbFile.PBContents = $pb
    foreach($handler in $pb.handlers) {
      $pbFile.SlotFiles += [CodeFile]::new($pb, $handler)
    }

    return $pbFile
  }

  [void]WriteSlotFiles(
    [bool]$Overwrite)
  {
    $this.SlotFiles.Write($Overwrite)
  }

  [void]ReadSlotFiles() 
  {
    $this.SlotFiles.Read()
    $this.UpdatePB()
  }

  [void]UpdatePB()
  {
    $unitFile = $this.SlotFiles | Where-Object {$_.FileName.Contains("unit.onStart__.1.lua")}
    # all of the requires go at the top of the unitFile
    $unitFileHeader = ""
    $reqProcessed = @()
    foreach($slot in $this.SlotFiles) {
      foreach($req in $slot.Requires.Keys)
      {
        if(-not $reqProcessed.Contains($req))
        {
          $reqProcessed += $req
          $unitFileHeader += @"

--== start file ${req} ==--

$($slot.Requires[$req] -join "`n")

--== end file ${req} ==--

"@
        }
      }

      $slot.Code = @"
--== start file $($slot.FileName) ==--

$($slot.Code -join "`n")

--== end file $($slot.FileName) ==--
"@

    }

    $unitFile.Code = @"
$unitFileheader

$($unitFile.Code)

"@

    # write the PB
    foreach($slotFile in $this.SlotFiles) {
      $handler = $this.PBContents.handlers | Where-Object {$_.key -eq $slotFile.HandlerKey}
      $handler.Code = [string]($slotFile.Code -join "`n" -replace "`r","")
    }
  }
}

function Invoke-PBDeconstruct(
  [string]$Path = "./PB.json",
  [switch]$FromClipboard,
  [switch]$Overwrite)
{
  if($FromClipboard) {
    $pb = [PBFile]::FromString((Get-Clipboard))
  }
  else {
    $pb = [PBFile]::FromFile($Path)
  }

  $pb.WriteSlotFiles($Overwrite.IsPresent)
}

function Invoke-PBConstruct(
  [string]$Path = "./PB.json",
  [switch]$ToClipboard)
{
  $pb = [PBFile]::FromFile($Path)
  $pb.ReadSlotFiles()
  $json = $pb.PBContents | ConvertTo-Json -Depth 10 -Compress
  if($ToClipboard) {
    $json | Set-Clipboard
  }
  else {
    $json | Set-Content $Path
  }
}

function Invoke-DisplayDeconstruct(
  [string]$Path = "./Display1.Merged.lua",
  [switch]$FromClipboard)
{
  if($FromClipboard) {
    $displayFile = [DisplayFile]::FromString((Get-Clipboard))
  }
  else {
    $displayFile = [DisplayFile]::FromFile($Path)
  }

  $displayFile.Write($true)
}

function Invoke-DisplayConstruct(
  [string]$Path = "./Display1.lua",
  [switch]$ToClipboard)
{
  $displayFile = [DisplayFile]::new($Path)

  if($ToClipboard) {
    $displayFile.Code | Set-Clipboard
  }
  else {
    $mergedFileName = $Path -replace ".lua",".Merged.lua"
    $displayFile.Code | Set-Content -Encoding Ascii -Path $mergedFileName
  }
}