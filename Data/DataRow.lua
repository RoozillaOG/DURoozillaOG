require "./UiCell.lua"
json = require("dkjson")

if not UiRow then
  UiRow = {}
  UiRow.__index = UiRow

  function UiRow(cells)
    local self = {
      ["data"] = {
        cells = cells or {}
      }
    }

    function self.AddCell(cell) 
      self.cells[#self.data.cells + 1] = cell
    end

    function self.NumCells()
      return #self.data.cells
    end

    function self.GetCells()
      return self.data.cells
    end

    function self.FromData(row)
      for kRow, kValue in pairs(row) do
        self.data.cells[#self.data.cells + 1] = UiCell(kValue.text, kValue.status)
      end
    end

    return self
  end
end