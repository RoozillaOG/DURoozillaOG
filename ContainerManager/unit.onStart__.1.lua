
require "../Industry/TransferManager.lua"
require "../Container/ContainerMonitor.lua"

transferManagers = {}
transferManagers["MainProductContainer1"] = TransferManager(
                                              sTransferUnit1,
                                              sInputContainer1
                                            )


containerMonitors = {}

containerMonitors["MainProductContainer1"] = ContainerMonitor(
                                               "MainProductContainer1", 
                                               sMainProductContainer1, 
                                               sDataBank
                                             )


for k, v in pairs(containerMonitors) do
  DebugPrint(k .. " Updating container data")
  v.Update()
  DebugPrint(v.GetDataBankKey() .. ": " .. json.encode(v.GetContent()))
end

for k, v in pairs(transferManagers) do
  DebugPrint(k .. "Updating transfer data")
  v.Update()
end


unit.setTimer("CheckTransfer", 5)
unit.setTimer("UpdateContainer", 35)

