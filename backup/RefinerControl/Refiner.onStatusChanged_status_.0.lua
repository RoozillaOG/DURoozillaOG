local json = require("dkjson")
local displayData = DisplayData(Refiner)
local containerData = ContainerContents(OutputContainer1)
for k, v in pairs(containerData.GetContents()) do
  displayData[#displayData + 1] = {v["name"],v["quantity"]}
end

local containerData = ContainerContents(OutputContainer2)
for k, v in pairs(containerData.GetContents()) do
  displayData[#displayData + 1] = {v["name"],v["quantity"]}
end
local displayJson = json.encode(displayData)

Display.setScriptInput(displayJson)




