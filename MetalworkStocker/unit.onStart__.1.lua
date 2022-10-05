
local json = require("dkjson")
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Element/Products.lua"
require "../Industry/IndustryStocker.lua"

unit.setTimer("Update", 30)
unit.setTimer("ContainerUpdate", 31)

OutputContainer1.updateContent()
resourceMapper = Products()

stocker = IndustryStocker(
    resourceMapper,
    Smelter,
    {OutputContainer1},
    {
        ["Steel product"] = 1000,
        ["Al-Fe Alloy product"] = 1000, 
        ["Silumin Product"] = 1000
    }
  )

stocker.Update()

unit.setTimer("ContainerUpdate", 31)
unit.setTimer("IndustryUpdate", 10)


