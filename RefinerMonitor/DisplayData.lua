
local json = require("dkjson")
require "../Mock/industry.lua"
require "../Utils/IndustryState.lua"
require "../Utils/ContainerContents.lua"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  ---@param refiner Industry
  function DisplayData(refiner,types)
    local self = {
      refiner = refiner,
      data = {},
      types = types or {}
    }
    
    function self.Update()
      self.data = {}
      self.data[#self.data + 1] = {"RefinerState", IndustryState[self.refiner.getState()]}
      local inputItem = system.getItem(self.refiner.getInputs()[1]["id"])
      local outputItem = system.getItem(self.refiner.getOutputs()[1]["id"])
    
      self.data[#self.data + 1] = {"InputName", inputItem["displayName"]}
      self.data[#self.data + 1] = {"OutputName", outputItem["displayName"]}
            
      local containerData = ContainerContents({OutputContainer1, OutputContainer2})
      local contents = containerData.GetContents()
      
      --system.print(json.encode(self.types))
      for k, v in pairs(self.types) do
        --system.print("Checking type: " .. "\"" .. v .. "\"")
        --system.print(json.encode(contents))
        if(contents[v]) then
          --system.print("Getting Quantity: " .. v)
          self.data[#self.data + 1] = {v,contents[v]["quantity"]}
        else
          self.data[#self.data + 1] = {v,0}
        end
                
        --system.print(json.encode(self.data[#self.data]))
      end
      local displayJson = json.encode(self.data)

      Display.setScriptInput(displayJson)
    end

    return self
  end
end


