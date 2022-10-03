
local json = require("dkjson")
require "./DisplayData.lua"
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Utils/PureResources.lua"
require "../Industry/IndustryStocker.lua"

unit.setTimer("Update", 30)
unit.setTimer("ContainerUpdate", 31)

OutputContainer1.updateContent()
resourceMapper = PureResources()

displayData = DisplayData(
    resourceMapper,
    Refiner,
    {OutputContainer1},
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
    {OutputContainer1},
    {
        ["Pure Aluminium"] = 1000,
        ["Pure Carbon"] = 1000, 
        ["Pure Iron"] = 1000, 
        ["Pure Silicon"] = 1000
    }
  )

displayData.Update()
stocker.Update()


