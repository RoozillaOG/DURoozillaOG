
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
      local displayData = {}

      for k, v in pairs(self.stockers) do
        displayData[#displayData + 1] = {
          v.GetName(),
          v.GetCurrentItem()
        }
      end

      DebugPrint("DisplayData: setting data = " .. json.encode(displayData))
      self.display.setScriptInput(json.encode(displayData))
    end

    return self
  end
end


