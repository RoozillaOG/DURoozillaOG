
--onstart
require "../Industry/IndustryStocker.lua"
require "../Utils/Metalworks.lua"
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Utils/ElectronicProducts.lua"
require "../Utils/threeDPrinter.lua"
require "../Container/ContainerData.lua"

DebugPrint("unit start")

stockers = {}

local dataKey = "MainProductContainer1.Data"
containerData = ContainerData(sDataBank, dataKey)
containerData.Update()

stockers[#stockers + 1] = IndustryStocker(
    "Metalworks1",
    MetalWorks(),
    sBasicMetalWorks1,
    containerData,
    {
      --  ["Basic Reinforced Frame xs"] = 5,
      --  ["Basic Standard Frame xs"] = 5,
      --  ["Basic Reinforced Frame s"] = 5,
      --  ["Basic Standard Frame s"] = 5,
      --  ["Basic Reinforced Frame m"] = 5,
      --  ["Basic Standard Frame m"] = 5,
      --  ["Basic Reinforced Frame l"] = 5,
      --  ["Basic Standard Frame l"] = 5,
        ["Basic Pipe"] = 600,
        ["Basic hydraulics"] = 600,
        ["Basic Screw"] = 600
      }
    )

stockers[#stockers + 1] = IndustryStocker(
    "Metalworks2",
    MetalWorks(),
    sBasicMetalWorks2,
    containerData,
    {
      --  ["Basic Reinforced Frame xs"] = 5,
      --  ["Basic Standard Frame xs"] = 5,
      --  ["Basic Reinforced Frame s"] = 5,
      --  ["Basic Standard Frame s"] = 5,
      --  ["Basic Reinforced Frame m"] = 5,
      --  ["Basic Standard Frame m"] = 5,
      --  ["Basic Reinforced Frame l"] = 5,
      --  ["Basic Standard Frame l"] = 5,
        ["Basic Pipe"] = 600,
        ["Basic hydraulics"] = 600,
        ["Basic Screw"] = 600
      }
  )

stockers[#stockers + 1] = IndustryStocker(
    "Electronics",
    ElectronicProducts(),
    sBasicElectronics1,
    containerData,
    {
      ["Basic Component"] = 600,
      ["Basic Connector"] = 600,
      ["Basic Electronics"] = 200
    }
  )

--stockers[#stockers + 1] = IndustryStocker(
--    "3DPrinter1",
--    ThreeDPrinter(),
--    s3DPrinter1,
--       sDataBank,
--       datakey,
--    electronics 
--  )

for k, v in pairs(stockers) do
  v.Update()
end

unit.setTimer("Update", 30)


