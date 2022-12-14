
--- Monitors the given industryUnit and stores content data to dataBank
-- @classmod IndustryMonitor

require "../Utils/DUDebug.lua"
require "../Data/DataCell.lua"
require "./IndustryData.lua"
require "./IndustryState.lua"

if not IndustryMonitor then
  IndustryMonitor = {}
  IndustryMonitor.__index = IndustryMonitor

  --- Returns a new IndustryMonitor object
  ---@param name string The short name of the industry
  ---@param industryUnit DU::Industry The DU industry object to monitor
  ---@param dataBank DU::DataBank The DataBank to store industry information to
  function IndustryMonitor(name, industryUnit, dataBank)
    local self = {
      name = name,
      industryUnit = industryUnit,
      dataBank = dataBank
    }
        
    --- Update the data on the industry unit. 
    -- Stores information like state, status, output, selected item
    function self.Update()
      system.print("Metalworks: Update()")
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


