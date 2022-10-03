

--== start file ..\Ui\ColorRGBA.lua ==--

if not ColorRGBA then
  ColorRGBA = {}
  ColorRGBA.__index = ColorRGBA

  function ColorRGBA(r, g, b, a)
    local self = {
      r = r or 0,
      g = g or 0,
      b = b or 0,
      a = a or 1.0
    }

    function self.LightGreen() return ColorRGBA(0.0, 0.3, 0.0, 0.3) end
    function self.LightRed() return ColorRGBA(0.3, 0.0, 0.0, 0.3) end
    function self.LightBlue() return ColorRGBA(0.0, 0.0, 0.3, 0.3) end
    function self.White() return ColorRGBA(0.7, 0.7, 0.7, 0.8) end
    function self.Black() return ColorRGBA(0.0, 0.0, 0.0, 0.8) end

    return self
  end
end

--== end file ..\Ui\ColorRGBA.lua ==--

--== start file ..\Ui\UiTable.lua ==--

--==require "./ColorRGBA.lua"
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
  function UiTable(layer, sx, sy, ex, ey, data)
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
      maxRowSize = 50,
      fontName = "Play",
      fontColor = ColorRGBA().White()
    }
        
    if(ex == nil) then
      self.ex, self.ey = getResolution()
    end

    local fontOne = loadFont(self.fontName, 50)
    local fontTwo = loadFont(self.fontName, 100)
    self.pixelsPerFontSize = (100 - 50) / (getFontSize(fontTwo) - getFontSize(fontOne))

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

--== end file ..\Ui\UiTable.lua ==--


--== start file .\Display1.lua ==--

--==require "../Ui/UiTable.lua"

local json = require("dkjson")

local layer = createLayer()
local sx,sy = getResolution()

local dataTable = UiTable(layer, 20.0, 20.0, sx - 20.0, sy - 20.0, json.decode(getInput()))
dataTable.gridLines = true
dataTable.oddRowColor = ColorRGBA().LightGreen()
dataTable.evenRowColor = ColorRGBA().LightBlue()
dataTable.Draw()

requestAnimationFrame(100)

--== end file .\Display1.lua ==--

