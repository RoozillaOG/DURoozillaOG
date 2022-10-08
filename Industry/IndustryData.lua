
require "../Data/DataGrid.lua"
require "../Data/DataRow.lua"
require "../Data/DataCell.lua"

if not IndustryData then
  IndustryData = {}
  IndustryData.__index = IndustryData

  function IndustryData()
    local self = {
      name = "",
      status = "",
      product = "",
      notification = ""
    }
    
    return self
  end

  function IndustryDataToDataGrid(data)
    dataGrid = DataGrid()
    for kRow, vRow in pairs(data) do
      local row = DataRow()
      row.AddCell(UiCell(vRow.name, vRow.notificaiton))
      row.AddCell(UiCell(vRow.status, vRow.notificaiton))
      row.AddCell(UiCell(vRow.product, vRow.notification))
      dataGrid.AddRow(row)
    end
    return dataGrid
  end
end


