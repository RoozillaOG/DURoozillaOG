
require "../Utils/DUDebug.lua"
require "../Industry/IndustryState.lua"

if not IndustryMonitor then
  IndustryMonitor = {}
  IndustryMonitor.__index = IndustryMonitor

  function IndustryData()
    local self = {
      name = "",
      status = "",
      product = "",
      notification = ""
    }
    
    return self
  end

  function IndustryMonitor(name, industryUnit, dataBank)
    local self = {
      name = name,
      industryUnit = industryUnit,
      dataBank = dataBank
    }
        
    function self.Update()
      system.print("Metalworks: Update()")
      if(self.dataBank) then
        system.print("Metalworks: Update() dataBank is not nil")
        local data = IndustryData()

        local info = self.industryUnit.getInfo()
        DebugPrint(self.name .. ": info: " .. json.encode(info))

        data.name = self.name
        data.state = IndustryState[self.industryUnit.getState()]
        if(data.state == "running") then
          data.notification = DataCellStatusGood
        elseif(data.state == "stopped") then
          data.state = DataCellStatusNormal
        else
          data.state = DataCellStatusNormal
        end

        local outputs = self.industryUnit.getOutputs()
        DebugPrint("Output: " .. json.encode(system.getItem(outputs[1].id).displayName))
        data.product = system.getItem(outputs[1].id).displayName

        local jsonRow = json.encode(data)
        DebugPrint(self.name .. ".info = " .. jsonRow)
        self.dataBank.setStringValue((self.name .. ".info"), jsonRow)
      end
    end

    return self
  end
end


