
----- Display.Core.lua ----
--=== start Display.Core.lua ===


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

local layer = createLayer()
local sx,sy = getResolution()

local dataTable = UiTable(layer, 20.0, 20.0, sx - 20.0, sy - 20.0, json.decode(getInput()))
dataTable.gridLines = true
dataTable.oddRowColor = ColorRGBA().LightGreen()
dataTable.evenRowColor = ColorRGBA().LightBlue()
dataTable.Draw()

requestAnimationFrame(100)

--=== end Display.Core.lua ===


--------------------------


----- DisplayData.lua ----
--=== start DisplayData.lua ===



if not IndustryState then
  IndustryState = {
   [1] = "Stopped",
   [2] = "Running",
   [3] = "Missing Ingredient",
   [4] = "Ouptut Full",
   [5] = "No Output Container",
   [6] = "Pending",
   [7] = "Missing Schematic"
  }
end
local json = require("dkjson")

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  ---@param refiner Industry
  function DisplayData(refiner)
    local self = {
      {"RefinerState", IndustryState[refiner.getState()]}
    }
    
    local inputItem = system.getItem(refiner.getInputs()[1]["id"])
    local outputItem = system.getItem(refiner.getOutputs()[1]["id"])
    
    self[#self + 1] = {"InputName", inputItem["displayName"]}
    self[#self + 1] = {"OutputName", outputItem["displayName"]}
        
    return self
  end
end

--=== end DisplayData.lua ===


--------------------------


----- IndustryState.lua ----
--=== start IndustryState.lua ===



if not IndustryState then
  IndustryState = {
   [1] = "Stopped",
   [2] = "Running",
   [3] = "Missing Ingredient",
   [4] = "Ouptut Full",
   [5] = "No Output Container",
   [6] = "Pending",
   [7] = "Missing Schematic"
  }
end
--=== end IndustryState.lua ===


--------------------------


----- RefinerControl.Update.lua ----
--=== start RefinerControl.Update.lua ===



if not DuElements then
  DuElements = {
    CarbonePure = "CarbonPure",
    AluminumPure = "AluminumPure",
    SiliconPure = "SiliconPure",
    IronPure = "IronPure",
    OxygenPure = "OxygenPure",
    HydrogenPure = "HydrogenPure"
  }
end

if not ContainerContents then
  ContainerContents = {}
  ContainerContents.__index = ContainerContents

  function ContainerContents(container) 
    for k, v in pairs(container.getContent()) do
      self[#self + 1] = {
        id = v["id"], 
        name = system.getItem(v["id"]), 
        quantity = v["quanitity"]
      }
    end

    function self.GetQuantity(name)
      for k, v in self do
        if(v["name"] == name) then
          return v["quantity"]
        end
      end
    end
    return self
  end
end

if not IndustryState then
  IndustryState = {
   [1] = "Stopped",
   [2] = "Running",
   [3] = "Missing Ingredient",
   [4] = "Ouptut Full",
   [5] = "No Output Container",
   [6] = "Pending",
   [7] = "Missing Schematic"
  }
end
local json = require("dkjson")

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  ---@param refiner Industry
  function DisplayData(refiner)
    local self = {
      {"RefinerState", IndustryState[refiner.getState()]}
    }
    
    local inputItem = system.getItem(refiner.getInputs()[1]["id"])
    local outputItem = system.getItem(refiner.getOutputs()[1]["id"])
    
    self[#self + 1] = {"InputName", inputItem["displayName"]}
    self[#self + 1] = {"OutputName", outputItem["displayName"]}
        
    return self
  end
end


local json = require("dkjson")

local displayData = DisplayData(Refiner)
local containerData = ContainerContents(OutputContainer1)
for k, v in pairs(containerData) do
  displayData[#displayData + 1] = v
end

local containerData = ContainerContents(OutputContainer2)
for k, v in pairs(containerData) do
  displayData[#displayData + 1] = v
end
local displayJson = json.encode(displayData)

Display.setScriptInput(displayJson)
--=== end RefinerControl.Update.lua ===


--------------------------


