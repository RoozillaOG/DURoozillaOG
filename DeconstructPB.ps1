param(
  [string]$Path = "PB.json",
  [switch]$FromClipboard,
  [switch]$Overwrite)

class PBCodeFile {
  [int]$HandlerKey
  [string]$FileName
  [string]$Code

  PBCodeFile(
    [PSObject]$PB,
    [PSObject]$Handler)
  {
    $slot = $pb.slots.$($handler.filter.slotKey)
    $this.HandlerKey = $handler.key
    $this.FileName = @(
      $slot.name,
      ($handler.filter.signature -replace "\(|\)","_"),
      $handler.key,
      "lua"
    ) -join "."

    $this.Code = $handler.code
  }

  [void]Write(
    [bool]$Overwrite) 
  {
    if(Test-Path $this.FileName) {
      if($Overwrite) {
        $this.Code | Set-Content $this.FileName
      }
    }
    else {
      $this.Code | Set-Content $this.FileName
    }
  }
}

class PBFile {
  [PSObject]$PBContents
  [PBCodeFile[]]$CodeFiles

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
      $pbFile.CodeFiles += [PBCodeFile]::new($pb, $handler)
    }

    return $pbFile
  }

  [void]WriteCodeFiles(
    [bool]$Overwrite) 
  {
    $this.CodeFiles.Write($Overwrite)
  }
}

if($FromClipboard) {
  $pb = [PBFile]::FromString((Get-Clipboard))
}
else {
  $pb = [PBFile]::FromFile($Path)
}

$pb.WriteCodeFiles($Overwrite.IsPresent)

