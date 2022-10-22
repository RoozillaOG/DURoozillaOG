
--- The main portion of code that creates the transfer units and container monitor lists.
-- timers will update the data periodically and modify what is being transfered.
-- @module ContainerManager.unit.OnStart

require "../../Industry/TransferManager.lua"
require "../../Container/ContainerMonitor.lua"
require "./DisplayData.lua"

containerMonitors = {}
transferManagers = {}

containerMonitors["TemporaryContainer1"] = ContainerMonitor(
                                             "TemporaryContainer1",
                                             sTemporaryContainer1,
                                             sDataBank
                                           )


transferManagers["MainProductContainer1"] = TransferManager(
                                              sTransferUnit1,
                                              containerMonitors["TemporaryContainer1"]
                                            )


containerMonitors["MainProductContainer1"] = ContainerMonitor(
                                               "MainProductContainer1", 
                                               sMainProductContainer1, 
                                               sDataBank
                                             )


for k, v in pairs(containerMonitors) do
  DebugPrint(k .. " Updating container data")
  v.Update()
  --DebugPrint(v.GetDataBankKey() .. ": " .. json.encode(v.GetContent()))
end

for k, v in pairs(transferManagers) do
  --DebugPrint(k .. "Updating transfer data")
  v.Update()
end

displayData = DisplayData(
  sTransferUnit1, 
  containerMonitors, 
  sDisplay1)
  
displayData.Update()

unit.setTimer("CheckTransfer", 5)
unit.setTimer("UpdateContainer", 35)
unit.setTimer("UpdateDisplay", 7)


