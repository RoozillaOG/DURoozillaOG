
local json = require("dkjson")
require "./DisplayData.lua"
require "../Utils/PureResources.lua"

--sDataBank.clear()
unit.setTimer("Update", 10)

system.print("Here: " .. sDataBank.getId())

resourceMapper = PureResources()
displayData = DisplayData(
    sDisplay,
    resourceMapper,
    sDataBank
  )

displayData.Update()


