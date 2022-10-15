
require "dkjson"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  function DisplayData(transferUnit, container, display)
    local self = {
      transferUnit = transferUnit,
      display = display,
      container = container
    }

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
        data,
        {"DataBank Key", self.container.GetDataBankKey()}
      }
      self.display.setScriptInput(json.encode(displayData))
    end
    
    return self
  end

end


