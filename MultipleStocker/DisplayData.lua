require "dkjson"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  function DisplayData(stockers, display)
    local self = {
      stockers = stockers,
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