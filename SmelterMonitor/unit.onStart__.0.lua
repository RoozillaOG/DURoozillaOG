
local json = require("dkjson")
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Element/Products.lua"
require "../Industry/IndustryStocker.lua"
require "../Industry/IndustryMonitor.lua"

sOutputContainer.updateContent()
resourceMapper = Products()

outputContents = ContainerContents(resourceMapper, {sOutputContainer})
outputContents.Update()

stocker = IndustryStocker(
    "Smelter",
    resourceMapper,
    sSmelter,
    outputContents,
    {
        ["Steel product"] = 1000,
        ["Al-Fe Alloy product"] = 1000, 
        ["Silumin Product"] = 1000
    }
  )

monitor = IndustryMonitor(
    "Smelter",
    sSmelter,
    sDataBank
  )

monitor.Update()
stocker.Update()

unit.setTimer("ContainerUpdate", 31)
unit.setTimer("IndustryUpdate", 10)


