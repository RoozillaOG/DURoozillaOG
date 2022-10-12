
--onstart
require "../Industry/IndustryStocker.lua"
require "../Utils/Metalworks.lua"
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Utils/ElectronicProducts.lua"
require "../Utils/threeDPrinter.lua"

outputContents = ContainerContents(resourceMapper, {sOutputContainer1})

stockers = {}

local metalworks = {
  ["Basic Reinforced Frame xs"] = 5,
  ["Basic Standard Frame xs"] = 5,
  ["Basic Reinforced Frame s"] = 5,
  ["Basic Standard Frame s"] = 5,
  ["Basic Reinforced Frame m"] = 5,
  ["Basic Standard Frame m"] = 5,
  ["Basic Reinforced Frame l"] = 5,
  ["Basic Standard Frame l"] = 5,
  ["Basic Pipe"] = 600,
  ["Basic hydraulics"] = 600,
  ["Basic Screw"] = 600
}

local electronics = {
  ["Basic Component"] = 600,
  ["Basic Connector"] = 600,
  ["Basic Electronics"] = 200
}

stockers[#stockers + 1] = IndustryStocker(
    "Metalworks1",
    MetalWorks(),
    sBasicMetalWorks1,
    outputContents,
    metalworks
  )

stockers[#stockers + 1] = IndustryStocker(
    "Metalworks2",
    MetalWorks(),
    sBasicMetalWorks2,
    outputContents,
    metalworks
  )

stockers[#stockers + 1] = IndustryStocker(
    "Electronics",
    ElectronicProducts(),
    sBasicElectronics1,
    outputContents,
    electronics 
  )

--stockers[#stockers + 1] = IndustryStocker(
--    "3DPrinter1",
--    ThreeDPrinter(),
--    s3DPrinter1,
--    outputContents,
--    electronics 
--  )

for k, v in pairs(stockers) do
  v.Update()
end

unit.setTimer("Update", 10)


