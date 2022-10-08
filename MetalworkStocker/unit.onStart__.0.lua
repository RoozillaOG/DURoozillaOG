
local json = require("dkjson")
require "../Industry/IndustryMonitor.lua"

monitor = IndustryMonitor(
    "Metalworks",
    sMetalWorks,
    sDataBank
  )

monitor2 = IndustryMonitor(
    "Metalworks2",
    sMetalWorks2,
    sDataBank
  )

monitor3 = IndustryMonitor(
    "s3DPrinter1",
    s3DPrinter1,
    sDataBank
  )

monitor.Update()
monitor2.Update()
monitor3.Update()

unit.setTimer("ContainerUpdate", 31)
unit.setTimer("IndustryUpdate", 10)


