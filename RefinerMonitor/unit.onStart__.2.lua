
local json = require("dkjson")
require "./DisplayData.lua"
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Element/PureResources.lua"
require "../Industry/IndustryStocker.lua"
require "../Utils/DUDebug.lua"
require "../Industry/IndustryMonitor.lua"

unit.setTimer("Update", 30)
unit.setTimer("ContainerUpdate", 31)

sOutputContainer.updateContent()
resourceMapper = PureResources()

-- wrapper around output containers
outputContents = ContainerContents(resourceMapper, {sOutputContainer})
outputContents.Update()

displayData = DisplayData(
    sDisplay,
    resourceMapper,
    sRefiner,
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
    "Refiner",
    resourceMapper,
    sRefiner,
    outputContents,
    {
        ["Pure Aluminium"] = 1000,
        ["Pure Carbon"] = 1000, 
        ["Pure Iron"] = 1000, 
        ["Pure Silicon"] = 1000
    }
  )

monitor = IndustryMonitor(
  "Refiner",
  sRefiner,
  sDataBank
)

displayData.Update()
stocker.Update()


