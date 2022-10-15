
require "./DataCell.lua"
json = require("dkjson")

if not DataRow then
  DataRow = {}
  DataRow.__index = DataRow

  function DataRow(cells)
    local self = {
      ["data"] = {
        cells = cells or {}
      }
    }

    function self.AddCell(cell) 
      self.data.cells[#self.data.cells + 1] = cell
    end

    function self.NumCells()
      return #self.data.cells
    end

    function self.GetCells()
      return self.data.cells
    end
        
    function self.Encode()
      return json.encode(self.data.cells)
    end
        
    function self.GetData()
      local data = {}
      for k, v in pairs(self.data.cells) do
        data[#data + 1] = v.GetData()
      end
            
      return data
    end

    function self.FromData(row)
      for kRow, kValue in pairs(row) do
        self.data.cells[#self.data.cells + 1] = DataCell(kValue.text, kValue.status)
      end
    end

    return self
  end
end


