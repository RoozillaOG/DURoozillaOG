
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
      local displayData = {}

      system.print("-----DisplayData.Update()")
      local keys = self.dataBank.getKeyList()
      system.print("Keys = " .. json.encode(keys))
      for k, v in pairs(keys) do
        system.print("Key " .. v)
        if(string.match(v, "Industry.")) then
          local data = self.dataBank.getStringValue(v)
          displayData[#displayData + 1] = data
        end
      end

      local displayJson = json.encode(displayData)
      display.setScriptInput(displayJson)
    end

    return self
  end
end


