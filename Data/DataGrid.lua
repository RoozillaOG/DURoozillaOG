
--- A grid of data represented by rows of columns
-- @classmod DataGrid

require "./DataRow.lua"
require "./DataCell.lua"

if not DataGrid then
  DataGrid = {}
  DataGrid.__index = DataGrid

  --- Create a new DataGrid
  ---@param rows DataRow Create from an existing row of data or nil
  function DataGrid(rows)
    local self = {
      classname = "DataGrid",
      ["data"] = {
        rows = rows or {}
      }
    }

    --- Add a new row of data to the end
    ---@param row DataRow The row to add
    function self.AddRow(row)
      self.data.rows[#self.data.rows + 1] = row
    end

    --- Get the number of columns determined by the first row
    -- @return number The number of columns
    function self.NumColumns()
      if(#self.data.rows > 0) then
        return self.data.rows[1].NumCells()
      end

      return 0
    end
    
    --- Get the number of rows in the grid
    -- @return number The number of rows in the DataGrid
    function self.NumRows()
      return #self.data.rows
    end
        
    --- Get the rows in the DataGrid
    -- @return DataRow Return list of DataRow
    function self.GetRows()
      return self.data.rows
    end
    
    --- Get the classname of this object
    -- @return string The classname of this object
    function self.GetClassName()
      return self.classname
    end

    --- Encodes the DataGrid to a json string
    -- @return string The json represented the encoded DataGrid
    function self.Encode()
      local data = {}
      for k, v in pairs(self.data.rows) do
        data[#data + 1] = v.GetData()
      end
            
      return json.encode(data)
    end

    --- Initializes the DataGrid from the given row data (table data only)
    ---@param rows table The table containing the row and columen data to initialize DataGrid with
    function self.FromRowData(rows)
      for kRow, vRow in pairs(rows) do
        local row = DataRow()
        row.FromData(vRow)
        self.AddRow(row)
      end
    end

    return self
  end
end


