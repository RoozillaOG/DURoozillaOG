
local json = require("dkjson")
require "./DisplayData.lua"
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Element/PureResources.lua"
require "../Industry/IndustryStocker.lua"

unit.setTimer("Update", 30)
unit.setTimer("ContainerUpdate", 31)

OutputContainer1.updateContent()
resourceMapper = PureResources()

-- wrapper around output containers
outputContents = ContainerContents(resourceMapper, {OutputContainer1})
outputContents.Update()

displayData = DisplayData(
    resourceMapper,
    Refiner,
    outputContents,
    {
      "Pure Aluminium",
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
    outputContents,
    {
        ["Pure Aluminium"] = 1000,
        ["Pure Carbon"] = 1000, 
        ["Pure Iron"] = 1000, 
        ["Pure Silicon"] = 1000
    }
  )

displayData.Update()
stocker.Update()


