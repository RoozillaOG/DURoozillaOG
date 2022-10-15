
require "dkjson"
require "../Data/DataCell.lua"
require "../Data/DataRow.lua"
require "../Data/DataGrid.lua"
require "../Utils/Utils.lua"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  function DisplayData(stockers, containerData, display)
    local self = {
      stockers = stockers,
      display = display,
      containerData = containerData
    }

    function self.Update()
      local dataGrid = DataGrid()
      local displayData = {}

      for k, v in pairs(self.stockers) do
        local row = DataRow()
        local stateName = v.GetStateName()
        local notification = DataCellStatusNormal
        if(stateName == "Stopped") then
          notification = DataCellStatusNormal
        elseif (stateName == "Running") then
          notification = DataCellStatusGood
        else
          notification = DataCellStatusAlert
        end

        row.AddCell(DataCell(UtilsShorten(v.GetName(), 10), notification))
        row.AddCell(DataCell(UtilsShorten(v.GetCurrentItem(), 10), notification))
        row.AddCell(DataCell(
                        math.floor(self.containerData.GetQuantityForName(v.GetCurrentItem())), 
                       notification)
                    )
        row.AddCell(DataCell(v.GetStateId(), notification))
        dataGrid.AddRow(row)
      end

      local jsonString = dataGrid.Encode()
      DebugPrint("DisplayData: setting data = " .. jsonString)
      self.display.setScriptInput(jsonString)
    end

    return self
  end
end


