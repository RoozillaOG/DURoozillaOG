
local json = require("dkjson")
require "./DisplayData.lua"
require "../Utils/PureResources.lua"

--sDataBank.clear()
unit.setTimer("Update", 10)

resourceMapper = PureResources()
displayData = DisplayData(
    sDisplay,
    resourceMapper,
    sDataBank
  )

displayData.Update()

--sLight.setColor(1.0, 0.0, 0.0)
--sLight.setOnBlinkingDuration(1)
--sLight.setOffBlinkingDuration(1)
--sLight.setBlinkingTimeShift(2)
--sLight.setBlinkingState(true)


