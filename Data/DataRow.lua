
--- A single row of DataCells
-- @classmod DataRow

require "./DataCell.lua"
json = require("dkjson")

if not DataRow then
  DataRow = {}
  DataRow.__index = DataRow

  --- Create a new DataRow object from the given list of cells
  ---@param cells DataCell List of data cells making up the row
  function DataRow(cells)
    local self = {
      classname = "DataRow",
      ["data"] = {
        cells = cells or {}
      }
    }

    --- Add a cell to the end of the cell list
    ---@param cell DataCell The cell to add
    function self.AddCell(cell) 
      self.data.cells[#self.data.cells + 1] = cell
    end

    --- Get the number of cells in the row
    -- @return number The number of cells in the row
    function self.NumCells()
      return #self.data.cells
    end

    --- Get all the cells in the row
    -- @return DataCell List of DataCells
    function self.GetCells()
      return self.data.cells
    end
    
    --- Encode the DataRow to json
    -- @return string Json representation of the DataRow
    function self.Encode()
      return json.encode(self.data.cells)
    end
        
    --- Get a single cell at the given index
    ---@param index number The 1-based index of the cell to return
    function self.GetCell(index)
      return self.data.cells[index] or nil
    end
    
    --- Return the classname of this object
    -- @return string The classname of this object
    function self.GetClassName()
      return self.classname
    end
    
    --- Return the data consisting of a table of DataCells
    -- @return DataCell List
    function self.GetData()
      local data = {}
      for k, v in pairs(self.data.cells) do
        data[#data + 1] = v.GetData()
      end
            
      return data
    end

    --- Unitialize from a set of row data (not class)
    ---@param row table A table of just the data for the row
    function self.FromData(row)
      for kRow, kValue in pairs(row) do
        self.data.cells[#self.data.cells + 1] = DataCell(kValue.text, kValue.status)
      end
    end

    return self
  end
end


