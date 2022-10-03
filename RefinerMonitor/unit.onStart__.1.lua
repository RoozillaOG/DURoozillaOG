
local json = require("dkjson")
require "./DisplayData.lua"
require "../Utils/ContainerContents.lua"
require "../Utils/DuElements.lua"
require "../Utils/IndustryState.lua"

unit.setTimer("Update", 10)
OutputContainer1.updateContent()
OutputContainer2.updateContent()

unit.setTimer("ContainerUpdate", 31)

displayData = DisplayData(
        Refiner, 
        {
          AluminiumPure, 
          CarbonPure, 
          IronPure, 
          SiliconPure, 
          OxygenPure, 
          HydrogenPure
        }
      )

displayData.Update()


