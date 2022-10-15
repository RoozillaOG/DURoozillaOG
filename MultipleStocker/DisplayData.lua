
require "dkjson"
require "../Data/DataCell.lua"
require "../Data/DataRow.lua"
require "../Data/DataGrid.lua"

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

        row.AddCell(DataCell(v.GetName(), notification))
        row.AddCell(DataCell(v.GetCurrentItem(), notification))
        row.AddCell(DataCell(
                        self.containerData.GetQuantityForName(v.GetCurrentItem()), 
                        notification)
                    )
        row.AddCell(DataCell(v.GetStateName(), notification))
        dataGrid.AddRow(row)
      end

      local jsonString = dataGrid.Encode()
      DebugPrint("DisplayData: setting data = " .. jsonString)
      self.display.setScriptInput(jsonString)
    end

    return self
  end
end


