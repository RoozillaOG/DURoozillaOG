
require "../Utils/DUDebug.lua"
require "../Data/DataCell.lua"
require "./IndustryData.lua"
require "./IndustryState.lua"

if not IndustryMonitor then
  IndustryMonitor = {}
  IndustryMonitor.__index = IndustryMonitor

  function IndustryMonitor(name, industryUnit, dataBank)
    local self = {
      name = name,
      industryUnit = industryUnit,
      dataBank = dataBank
    }
        
    function self.Update()
      if(self.dataBank) then
        local data = IndustryData()

        local info = self.industryUnit.getInfo()
        DebugPrint(self.name .. ": info: " .. json.encode(info))

        data.name = self.name
        DebugPrint("state: " .. json.encode(self.industryUnit.getState()))
        data.status = self.industryUnit.getState()
        local statusString = IndustryState[data.status]
        if(statusString == "Running") then
          data.notification = DataCellStatusGood
        elseif(statusString == "Stopped") then
          data.notification = DataCellStatusNormal
        else
          data.notification = DataCellStatusAlert
        end

        local outputs = self.industryUnit.getOutputs()
        if(#outputs > 0) then
          DebugPrint("Output: " .. json.encode(system.getItem(outputs[1].id).displayName))
          data.product = system.getItem(outputs[1].id).displayName
        else
          data.product = "None"
        end
        local jsonRow = json.encode(data)
        DebugPrint(self.name .. ".info = " .. jsonRow)
        self.dataBank.setStringValue(("Industry" .. self.name .. ".info"), jsonRow)
      end
    end

    return self
  end
end


