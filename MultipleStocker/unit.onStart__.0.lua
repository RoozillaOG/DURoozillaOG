
--onstart
require "../Industry/IndustryStocker.lua"
require "../Utils/Metalworks.lua"
require "../Container/ContainerContents.lua"
require "../Industry/IndustryState.lua"
require "../Utils/ElectronicProducts.lua"
require "../Utils/threeDPrinter.lua"
require "../Container/ContainerData.lua"
require "./DisplayData.lua"
require "../Utils/PureResources.lua"
require "../Utils/Products.lua"

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

stockers[#stockers + 1] = IndustryStocker(
    "Smelter",
    Products(),
    sSmelter,
    containerData,
    {
        ["Steel product"] = 1000,
        ["Al-Fe Alloy product"] = 1000, 
        ["Silumin Product"] = 1000
    }
  )

stockers[#stockers + 1] = IndustryStocker(
    "GlassWorks",
    Products(),
    sGlassWorks,
    containerData,
    {
    }
  )

stockers[#stockers + 1] = IndustryStocker(
    "Chemical",
    Products(),
    sChemical,
    containerData,
    {
    }
  )

  stockers[#stockers + 1] = IndustryStocker(
    "Refiner",
    PureResources(),
    sBasicRefiner1,
    containerData,
    {
      ["Pure Aluminium"] = 1500,
      ["Pure Carbon"] = 1500,
      ["Pure Chromium"] = 1500,
      ["Pure Copper"] = 1500,
      ["Pure Iron"] = 1500
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

displayData = DisplayData(stockers, containerData, sDisplay1)
displayData.Update()

unit.setTimer("Update", 10)


