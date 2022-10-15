
local json = require("dkjson")
require "../Industry/IndustryMonitor.lua"
monitors = {}

monitors[#monitors + 1] = IndustryMonitor(
    "BMetalworks",
    sMetalWorks,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BMetalworks2",
    sMetalWorks2,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "B3DPrinter1",
    s3DPrinter1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BAssemblyS1",
    sBasicAssemblyS1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BAssemblyM1",
    sBasicAssemblyM1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BAssemblyL1",
    sBasicAssemblyL1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BElectronics1",
    sBasicElectronics1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BSmelter1",
    sBasicSmelter1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BRefiner1",
    sBasicRefiner1,
    sDataBank
  )

for k, v in pairs(monitors) do
  v.Update()
end

unit.setTimer("IndustryUpdate", 10)


