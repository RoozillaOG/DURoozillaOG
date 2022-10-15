
require "dkjson"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  function DisplayData(transferUnit, display)
    local self = {
      transferUnit = transferUnit,
      display = display
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
      self.display.setScriptInput(json.encode({data}))
    end
    
    return self
  end

end


