
local json = require("dkjson")
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Element/Products.lua"
require "../Industry/IndustryStocker.lua"

OutputContainer1.updateContent()
resourceMapper = Products()

outputContents = ContainerContents(resourceMapper, {OutputContainer1})
outputContents.Update()

stocker = IndustryStocker(
    resourceMapper,
    Smelter,
    outputContents,
    {
        ["Steel product"] = 1000,
        ["Al-Fe Alloy product"] = 1000, 
        ["Silumin Product"] = 1000
    }
  )

stocker.Update()

unit.setTimer("ContainerUpdate", 31)
unit.setTimer("IndustryUpdate", 10)


