# param(
#   [Parameter(Mandatory=$true)][string]$LuaFile,
#   [string]$OutputFile,
#   [switch]$CopyToClipboard)

class MergedScript {
  [string[]]$Requires = @()
  [hashtable]$ScriptPieces = @{}
  [string[]]$Script = @()
  [string]$Name

  [void]DoMerge(
    [string]$Path)
  {
    $processed = @()
    foreach($require in $this.Requires) {
      if(-not $processed.Contains($require))
      {
        $processed += $require
        if($require -ne $this.Name) {
          $this.Script += "`n--== start require ==--`n"
          $this.Script += "--== require $require ==--"
        }
        else {
          $this.Script += "`n--== main ==--`n"
        }
        $this.Script += $this.ScriptPieces[$require] -join "`n"
        if($require -ne $this.Name) {
          $this.Script += "`n--== end require ==--`n"
        }
        else {
          $this.Script += "`n--== end main ==--`n"
        }
      }
    }
  }

  [void]GetRequires(
    [string]$Path)
  {
    if($this.Requires.Contains($Path)) {
      # Move to the top of list, already been processed, but dependency moved up
      Write-Host "Moving dependency $Path to top"
      $this.Requires = @($Path) + $this.Requires
      return
    }

    $scriptContent = (Get-Content -Path $Path)
    $newContent = $scriptContent | Select-String -NotMatch ".*-- mock variable"
    $requireList = @()
    $requireList = $scriptContent -match "^require `".*.lua`""
    if($requireList -ne "False") {
      foreach($require in $requireList) {
        Write-Host "Processing dependency $require"
        if($require -match "^require `"(?<path>.*.lua)`"") {
          Write-Host "  - local dependency"
          if(Test-Path "$((Get-Item $Path).Directory)/$($Matches.path)") {
            if(-not $require.Contains("Mock")) {
              Write-Host "  - Including content from $((Get-Item $Path).Directory)/$($Matches.path)"
              $this.GetRequires("$((Get-Item $Path).Directory)/$($Matches.path)")
            }
            else {
              Write-Host "  - ignoring mock data"
            }
            Write-Host "  - Removing require reference "
            $newContent = ($newContent | Select-string -NotMatch "^require `".*$(Split-Path $Matches.path -Leaf)`"")
          }
        }
      }
    }
    $this.Requires += $Path
    $this.ScriptPieces[$Path] = $newContent
  }

  MergedScript(
    [string]$Path)
  {
    $this.Name = $Path
    $this.GetRequires($Path)
    $this.DoMerge($Path)
  }
}

function Invoke-Build(
  [string]$Path,
  [switch]$CopytoClipboard) 
{
  if(Test-Path -Path .\Merged.lua) {
    Remove-Item -Path .\Merged.lua
  }

  $files = ""
  if($Path) {
    $files = Get-Item -Path $Path
  }
  else {
    $files = Get-ChildItem . -Filter *.lua
    $scripts = @()
  }
  
  foreach($file in $files) {
    Write-Host "Processing script $($file.Name)"
    $scripts += [MergedScript]::new($file.Name)
  }

  "" | Set-Content .\Merged.lua
  foreach($script in $scripts) {
    @"
----- $($script.Name) ----
$($script.Script -join "`n")

--------------------------


"@ | Add-Content .\Merged.lua

  }

  if($CopytoClipboard) {
    Get-Content .\Merged.lua | Set-Clipboard
  }
}

class PBSlotFile {
  [int]$HandlerKey
  [string]$FileName
  [hashtable]$Requires = @{}
  [string[]]$Code

  PBSlotFile(
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

  [void]Write(
    [bool]$Overwrite) 
  {
    $requiresFound = @()
    $parts = ($this.Code.Trim() -split "--== start file ")
    foreach($part in ($parts | Where-Object {$_ -ne ""})) {
      $allLines = ($part -join "`n" -split "--== end file")[0]
      if($allLines -match "(?<path>.*?) ==--") {
        $lines = $allLines -split "\n" | Select-String -NotMatch " ==--"
        $cleanedCode = $lines -join "`n"
        $cleanedCode = $cleanedCode -replace "--==require","require"
        $requiresFound += Resolve-Path -Path $Matches.path -Relative
        Write-Host "Writing $($Matches.path)"
        Write-Host " - With relative path $($requiresFound[-1])"
        Write-Host 
        if((Test-Path -Path $requiresFound[-1]) -and ($Overwrite -eq $false)) {
          Write-Host " - Skipping write since Overwrite was not true"
        }
        else {
          $cleanedCode | Set-Content -Encoding Ascii -Path $requiresFound[-1]
        }
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
          $this.Requires[$Path] = $this.Requires[$Path] -join "`n" -replace "require `"${reqPath}`"","" -split "`n"
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

class PBFile {
  [PSObject]$PBContents
  [PBSlotFile[]]$SlotFiles

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
      $pbFile.SlotFiles += [PBSlotFile]::new($pb, $handler)
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