
local json = require("dkjson")
require "./DisplayData.lua"
require "../Container/ContainerContents.lua"
require "../Utils/DuElements.lua"
require "../Industry/IndustryState.lua"

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

stocker = IndustryStocker(
    Refiner,
    OutputContainer1,
    {
        AluminiumPure = 1000,
        CarbonPure = 1000, 
        IronPure = 1000, 
        SiliconPure = 1000
    }
  )

stocker.Update()



