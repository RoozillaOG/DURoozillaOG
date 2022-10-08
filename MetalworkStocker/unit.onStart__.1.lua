
local json = require("dkjson")
require "../Industry/IndustryMonitor.lua"

monitor = IndustryMonitor(
    "Metalworks",
    sMetalWorks,
    sDataBank
  )

monitor.Update()

unit.setTimer("ContainerUpdate", 31)
unit.setTimer("IndustryUpdate", 10)


