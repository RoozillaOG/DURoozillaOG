
require "../Data/DataGrid.lua"
require "../Data/DataRow.lua"
require "../Data/DataCell.lua"
require "./IndustryState.lua"

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
      local rowData = json.decode(vRow)
      logMessage("Rowdata notification: " .. rowData.notification)
      row.AddCell(DataCell(rowData.name, rowData.notification))
      row.AddCell(DataCell(IndustryState[rowData.status], rowData.notification))
      row.AddCell(DataCell(rowData.product, rowData.notification))
      dataGrid.AddRow(row)
    end
    return dataGrid
  end
end


