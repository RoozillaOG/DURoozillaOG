local json = require("dkjson")
require "../Mock/industry.lua"
require "./IndustryState.lua"
require "../Utils/ContainerContents.lua"

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
    
    function self.Update()
      for k, v in pairs(containerData.GetContents()) do
        displayData[#displayData + 1] = {v["name"],v["quantity"]}
      end

      local containerData = ContainerContents(OutputContainer2)
      for k, v in pairs(containerData.GetContents()) do
        displayData[#displayData + 1] = {v["name"],v["quantity"]}
      end
      local displayJson = json.encode(displayData)

      Display.setScriptInput(displayJson)
    end

    return self
  end
end

