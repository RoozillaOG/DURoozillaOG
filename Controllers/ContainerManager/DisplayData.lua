--- Contains the data used to transfer between PB and display screen
-- @classmod ContainerManager.DisplayData

local json = require("dkjson")

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  --- Creates a new DisplayData object
  ---@param transferUnit Industry The transfer unit reference
  ---@param containers Container The containers being monitored
  ---@param display Display The display unit to send data to via setScriptInput()
  function DisplayData(transferUnit, containers, display)
    local self = {
      transferUnit = transferUnit,
      display = display,
      containers = containers
    }

    --- Updates the DisplayData based on current state of Transfer unit and Containers
    function self.Update()
      local data = {
        "Transfering"
      }

      local output = self.transferUnit.getOutputs()
      if(output) then
        data[#data + 1] = system.getItem(output[1].id).displayName
      else
        data[#data + 1] = "None"
      end

      local displayData = {
        data
      }
            
      for k, v in pairs(self.containers) do
        displayData[#displayData + 1] = {v.GetContainerName(), v.GetDataBankKey()}
      end
      self.display.setScriptInput(json.encode(displayData))
    end
    
    return self
  end

end


