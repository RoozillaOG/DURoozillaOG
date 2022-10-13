sInputContainer1.updateContent()
local contents = sInputContainer1.getContent()
if(contents) then
  DebugPrint(">>>> Adding contents to databank: ")
  sDataBank.setStringValue("Container.Merged.Content", json.encode(contents))
  DebugPrint("<<<< Ended databank update")
end
