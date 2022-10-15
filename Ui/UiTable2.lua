
require "./ColorRGBA.lua"
require "../Data/DataGrid.lua"
require "../Data/DataCell.lua"
require "../Data/DataRow.lua"
require "./UiRow.lua"
require "./UiCell.lua"

local json = require("dkjson") 

if not UiTable2 then
  UiTable2 = {}
  UiTable2.__index = UiTable2

  ---@param layer any The layer to draw to
  ---@param sx number Starting x location of table
  ---@param sy number Starting y location of table
  ---@param ex number Ending x location of table 
  ---@param ey number Ending y location of table
  ---@param data table A table of rows containing a table of columns to dislay in the table 
  function UiTable2(layer, sx, sy, ex, ey, dataGrid, fontname)
    local self = {
      sx = sx or 0.0,
      sy = sy or 0.0,
      ex = ex or 0.0,
      ey = ey or 0.0,
      dataGrid = dataGrid or nil,
      gridLines = false,
      evenRowColor = nil,
      oddRowColor = nil,
      spacingInPixels = 5,
      pixelsPerFontSize = 1.0,
      maxRowSize = 100,
      fontName = fontname or "RefrigeratorDeluxe",
      fontColor = ColorRGBA().White()
    }
        
    if(ex == nil) then 
      self.ex, self.ey = getResolution()
    end

    local fontOne = loadFont(self.fontName, 50)
    local fontTwo = loadFont(self.fontName, 100)
    self.pixelsPerFontSize = (100 - 50) / (getFontSize(fontTwo) - getFontSize(fontOne))

    function self.Draw()
      local numRows = self.dataGrid.NumRows()

      local rowHeightInPixels = (ey - sy) / numRows
      if(rowHeightInPixels > self.maxRowSize) then
        rowHeightInPixels = self.maxRowSize
      end

      local textHeightInPixles = rowHeightInPixels - self.spacingInPixels
      local fontSize = textHeightInPixles / self.pixelsPerFontSize

      local font = loadFont(self.fontName, fontSize)
      local cy = sy
      local numColumns = self.dataGrid.NumColumns()
      local colWidth = (ex - sx) / numColumns
      local rowNumOdd = true
      for kRow, vRow in pairs(self.dataGrid.GetRows()) do
        local cx = sx
        for kCell, vCell in pairs(vRow.GetCells()) do
          self.DrawCell(layer, vCell, font, cx, cy, colWidth, rowHeightInPixels)
          cx = cx + colWidth
        end
        cy = cy + rowHeightInPixels
      end
    end

    function self.DrawCell(layer, cell, font, sx, sy, width, height)
      local notification = cell.GetNotification()
      local fillColor = ColorRGBABlack

      logMessage("Notification: " .. DataCellStatusAlert .. " = " .. json.encode(notification))
      if(notification == DataCellStatusGood) then
        fillColor = ColorRGBALightGreen      
      elseif(notification == DataCellStatusWarning) then
        fillColor = ColorRGBALightYellow
      elseif(notification == DataCellStatusAlert) then
        fillColor = ColorRGBALightRed
      end
      
      setNextFillColor(layer, fillColor.r, fillColor.g, fillColor.b, fillColor.a)
      addBox(layer, sx, sy, width, height)
  
      setNextTextAlign(layer, AlignH_Left, AlignV_Top)
      setNextStrokeColor(layer, ColorRGBAWhite.r, ColorRGBAWhite.g, ColorRGBAWhite.b, ColorRGBAWhite.a)
      logMessage("Cell " .. json.encode(cell.GetData()))
      addText(layer, font, cell.GetText(), sx, sy)
    end

    return self
  end
end


