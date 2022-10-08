
local json = require("dkjson")
require "../Mock/industry.lua"
require "../Industry/IndustryState.lua"
require "../Container/ContainerContents.lua"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  ---@param refiner Industry
  function DisplayData(display, resourceMapper,refiner,outputContents,types)
    local self = {
      display = display,
      refiner = refiner,
      data = {},
      types = types or {},
      resourceMapper = resourceMapper,
      outputContents = outputContents
    }
    
    function self.Update()
      self.data = {}
      self.data[#self.data + 1] = {"RefinerState", IndustryState[self.refiner.getState()]}

      local inputItemName = self.resourceMapper.GetDisplayName(self.refiner.getInputs()[1].id)
      local outputItemName = self.resourceMapper.GetDisplayName(self.refiner.getOutputs()[1].id)
    
      self.data[#self.data + 1] = {"Input Item", inputItemName}
      self.data[#self.data + 1] = {"Output Item", outputItemName}
            
      self.data[#self.data + 1] = {"Uptime", self.refiner.getCycleCountSinceStartup()}
      
      for itemKey, itemValue in pairs(self.types) do
        self.data[#self.data + 1] = {itemValue, math.floor(outputContents.GetQuantityForName(itemValue))}
      end

      local displayJson = json.encode(self.data)
      DebugPrint("Refiner.Update(): " .. displayJson)
      display.setScriptInput(displayJson)
    end

    return self
  end
end


