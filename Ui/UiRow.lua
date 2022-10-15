
require "./UiCell.lua"

if not UiRow then
  UiRow = {}
  UiRow.__index = UiRow

  function UiRow(cells)
    self = {
      cells = cells or {}
    }

    function self.AddCell(cell) 
      self.cells[#self.cells + 1] = cell
    end

    function self.NumCells()
      return #self.cells
    end

    return self
  end
end


