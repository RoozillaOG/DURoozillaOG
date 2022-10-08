
local json = require("dkjson")
require "../Mock/industry.lua"
require "../Industry/IndustryData.lua"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  ---@param dataBank DataBank
  function DisplayData(display, resourceMapper, dataBank)
    local self = {
      display = display,
      resourceMapper = resourceMapper,
      dataBank = dataBank
    }
    
    function self.Update()
      local dataGrid = DataGrid()

      local keys = self.dataBank.getKeys()
      for k, v in pairs(keys) do
        if(string.match(v, "Industry.")) then
          local data = self.dataBand.getStringValue(v)
          DebugPrint(v .. " = " .. json.encode(data))
        end
      end

      local displayJson = json.encode(data)
      display.setScriptInput(displayJson)
    end

    return self
  end
end
