
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
      logMessage("---row: " .. vRow)
      local rowData = json.decode(vRow)
      row.AddCell(DataCell(rowData.name, rowData.notification))
      row.AddCell(DataCell(rowData.status, rowData.notification))
      row.AddCell(DataCell(rowData.product, rowData.notification))
      dataGrid.AddRow(row)
    end
    return dataGrid
  end
end


