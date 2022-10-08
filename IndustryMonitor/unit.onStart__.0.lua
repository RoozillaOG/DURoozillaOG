
local json = require("dkjson")
require "../Industry/IndustryMonitor.lua"
monitors = {}

monitors[#monitors + 1] = IndustryMonitor(
    "Metalworks",
    sMetalWorks,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "Metalworks2",
    sMetalWorks2,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "s3DPrinter1",
    s3DPrinter1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BasicAssemblyS1",
    sBasicAssemblyS1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BasicAssemblyM1",
    sBasicAssemblyM1,
    sDataBank
  )

monitors[#monitors + 1] = IndustryMonitor(
    "BasicAssemblyL1",
    sBasicAssemblyL1,
    sDataBank
  )

for k, v in pairs(monitors) do
  v.Update()
end

unit.setTimer("ContainerUpdate", 31)
unit.setTimer("IndustryUpdate", 10)


