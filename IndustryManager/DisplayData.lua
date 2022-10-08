
local json = require("dkjson")
require "../Mock/industry.lua"
require "../Data/DataGrid.lua"
require "../Data/DataRow.lua"
require "../Data/DataCell.lua"

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
      local data = {}
      local dataGrid = DataGrid()
      if(self.dataBank.hasKey("Refiner.info")) then
        obj = json.decode(self.dataBank.getStringValue("Refiner.info"))
        dataGrid.AddFromRowData(obj)
      end

      local displayJson = json.encode(data)
      display.setScriptInput(displayJson)
    end

    return self
  end
end
