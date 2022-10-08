
local json = require('dkjson')

content = Container.getContent()
for i, item in ipairs(content) do
  itemDetails = system.getItem(item.id)
  itemDetailsJson =  json.encode(itemDetails)
end

contentJson = json.encode(content)

Display.setScriptInput(contentJson)