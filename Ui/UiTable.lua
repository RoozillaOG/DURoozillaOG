
require "./ColorRGBA.lua"
local json = require("dkjson") 

if not UiTable then
  UiTable = {}
  UiTable.__index = UiTable

  ---@param layer any The layer to draw to
  ---@param sx number Starting x location of table
  ---@param sy number Starting y location of table
  ---@param ex number Ending x location of table 
  ---@param ey number Ending y location of table
  ---@param data table A table of rows containing a table of columns to dislay in the table
  function UiTable(layer, sx, sy, ex, ey, data, fontSize)
    local self = {
      sx = sx or 0.0,
      sy = sy or 0.0,
      ex = ex or 0.0,
      ey = ey or 0.0,
      data = data or nil,
      gridLines = false,
      evenRowColor = nil,
      oddRowColor = nil,
      spacingInPixels = 5,
      pixelsPerFontSize = 1.0,
      maxRowSize = fontSize or 50,
      fontName = "Play",
      fontColor = ColorRGBA().White()
    }
        
    if(ex == nil) then 
      self.ex, self.ey = getResolution()
    end

    if(fontSize == nil) then
      local fontOne = loadFont(self.fontName, 50)
      local fontTwo = loadFont(self.fontName, 100)
      self.pixelsPerFontSize = (100 - 50) / (getFontSize(fontTwo) - getFontSize(fontOne))
    end
            
    function self.Draw()
      local numRows = #data
      local rowHeightInPixels = (ey - sy) / numRows
      if(rowHeightInPixels > self.maxRowSize) then
        rowHeightInPixels = self.maxRowSize
      end

      local textHeightInPixles = rowHeightInPixels - self.spacingInPixels
      local fontSize = textHeightInPixles / self.pixelsPerFontSize

      local font = loadFont(self.fontName, fontSize)
      local cy = sy
      local numColumns = #(self.data[1])
      local colWidth = (ex - sx) / numColumns
      local rowNumOdd = true
      for k, v in pairs(self.data) do
        logMessage("v = " .. json.encode(v))
        local cx = sx
        for i= 1, numColumns do
          if (rowNumOdd == true) then
            if (self.oddRowColor ~= nil) then
              setNextFillColor(layer, self.oddRowColor.r, self.oddRowColor.g, self.oddRowColor.b, self.oddRowColor.a)
              addBox(layer, cx, cy, colWidth, rowHeightInPixels)
            end
          end
                    
          if (rowNumOdd == false) then
            if (self.evenRowColor) then
              setNextFillColor(layer, self.evenRowColor.r, self.evenRowColor.g, self.evenRowColor.b, self.evenRowColor.a)
              addBox(layer, cx, cy, colWidth, rowHeightInPixels)
            end
          end
          
          setNextTextAlign(layer, AlignH_Left, AlignV_Top)
          setNextStrokeColor(layer, self.fontColor.r, self.fontColor.g, self.fontColor.b, self.fontColor.a)
          addText(layer, font, v[i], cx, cy)
          cx = cx + colWidth
        end

        cy = cy + rowHeightInPixels
        if(rowNumOdd == true) then
          rowNumOdd = false
        else
          rowNumOdd = true
        end
      end
    end

    return self
  end
end


