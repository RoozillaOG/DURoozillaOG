
local json = require('dkjson')

system.print("CONTAINER UPDATE EVENT")
system.print("Retrieving content")

content = Container.getContent()
for i, item in ipairs(content) do
  itemDetails = system.getItem(item.id)
  itemDetailsJson =  json.encode(itemDetails)
  system.print(itemDetails.displayNameWithSize .. " - " .. item.quantity)
  system.print(itemDetailsJson)
end

contentJson = json.encode(content)
system.print(contentJson)

Display.setScriptInput(contentJson)