local json = require('dkjson')

system.print("Setting timer")
unit.setTimer("ContainerUp", 32)

system.print("Updating Content")

content = Container.updateContent()

system.print("Retrieving content")

--content = Container.getClass()
--contentJson = content --json.encode(content)

Display.setScriptInput(content)