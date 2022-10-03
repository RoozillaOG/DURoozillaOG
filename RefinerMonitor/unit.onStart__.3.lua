
local json = require("dkjson")
require "./DisplayData.lua"
require "../Container/ContainerContents.lua"
require "../Utils/DuElements.lua"
require "../Industry/IndustryState.lua"
require "../Utils/PureResources.lua"

unit.setTimer("Update", 10)
unit.setTimer("ContainerUpdate", 31)

resourceMapper = PureResources()

displayData = DisplayData(
    resourceMapper,
    Refiner, 
    {
      "Pure Aluminum",
      "Pure Carbon",
      "Pure Iron",
      "Pure Silicon",
      "Pure Hydrogen",
      "Pure Oxygen"
    }
  )

stocker = IndustryStocker(
    resourceMapper,
    Refiner,
    OutputContainer1,
    {
        ["Pure Aluminum"] = 1000,
        ["Pure Carbon"] = 1000, 
        ["Pure Iron"] = 1000, 
        ["Pure Silicon"] = 1000
    }
  )

OutputContainer1.updateContent()
displayData.Update()
stocker.Update()



