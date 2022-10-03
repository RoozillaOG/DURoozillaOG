
local json = require("dkjson")
require "../Mock/industry.lua"
require "../Industry/IndustryState.lua"
require "../Container/ContainerContents.lua"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  ---@param refiner Industry
  function DisplayData(resourceMapper,refiner,types)
    local self = {
      refiner = refiner,
      data = {},
      types = types or {},
      resourceMapper = resourceMapper
    }
    
    function self.Update()
      self.data = {}
      self.data[#self.data + 1] = {"RefinerState", IndustryState[self.refiner.getState()]}
      local inputItem = self.resourceMapper.GetDisplayName(self.refiner.getInputs()[1].id)
      local outputItem = self.resourceMapper.GetDisplayName(self.refiner.getOutputs()[1].id)
    
      self.data[#self.data + 1] = {"InputName", inputItem["displayName"]}
      self.data[#self.data + 1] = {"OutputName", outputItem["displayName"]}
            
      self.data[#self.data + 1] = {"Uptime", self.refiner.getCycleCountSinceStartup()}
            
      local containerData = ContainerContents(self.resourceMapper, {OutputContainer1, OutputContainer2})
      local contents = containerData.GetContents()
      
      for itemKey, itemValue in pairs(self.types) do
        self.data[#self.data + 1] = {itemName, contents.GetQuantityForName(itemName)}
      end

      local displayJson = json.encode(self.data)
      Display.setScriptInput(displayJson)
    end

    return self
  end
end


