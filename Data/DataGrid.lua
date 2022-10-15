
require "./DataRow.lua"
require "./DataCell.lua"

if not DataGrid then
  DataGrid = {}
  DataGrid.__index = DataGrid

  function DataGrid(rows)
    local self = {
      ["data"] = {
        rows = rows or {}
      }
    }

    function self.AddRow(row)
      self.data.rows[#self.data.rows + 1] = row
    end
        
    function self.GetRows()
      return self.data.rows
    end
        
    function self.NumRows()
      return #self.data.rows
    end

    function self.NumColumns()
            
      if(#self.data.rows > 0) then
        return self.data.rows[1].NumCells()
      end

      return 0
    end

    function self.Encode()
      local data = {}
            
      for k, v in pairs(self.data.rows) do
        data[#data + 1] = v.GetData()
      end
            
      return json.encode(data)
    end

    function self.FromRowData(rows)
      for kRow, vRow in pairs(rows) do
        local row = DataRow()
        row.FromData(vRow)
        self.AddRow(row)
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


