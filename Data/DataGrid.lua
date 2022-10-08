require "./UiRow.lua"
require "./UiCell.lua"

if not UiDataGrid then
  UiDataGrid = {}
  UiDataGrid.__index = UiDataGrid

  function UiDataGrid(rows)
    self = {
      ["data"] = {
        rows = rows or {}
      }
    }

    function self.AddRow(row)
      self.data.rows[#self.data.rows + 1] = row
    end

    function self.NumColumns()
      if(#self.rows > 0) then
        return self.data.rows[0].NumCells()
      end

      return 0
    end

    function self.Encode()
      return self.data.rows.Encode()
    end

    function self.FromRowData(rows) 
      for kRow, vRow in rows do
        local row = DataRow()
        row.FromData(vRow)
        self.data.rows[#self.data.rows + 1] = row
      end
    end

    function self.Decode(json)
      obj = json.decode(json)
      for kRow, vRow in pairs(obj) do
        local row = DataRow()
        row.FromData(vRow)
        self.data.rows[#self.data.rows + 1] = row
      end
    end

    return self
  end
end