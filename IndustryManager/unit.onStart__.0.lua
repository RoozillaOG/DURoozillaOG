local json = require("dkjson")
require "./DisplayData.lua"
require "../Utils/PureResources.lua"


resourceMapper = PureResources()
displayData = DisplayData(
    sDisplay,
    resourceMapper,
    sDataBank
  )

displayData.Update()


