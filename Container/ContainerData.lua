
require "dkjson"
require "../Utils/DUDebug.lua"

if not ContainerData then
  ContainerData = {}
  ContainerData.__index = ContainerData

  function ContainerData(dataBank, dataKey)
    local self = {
      dataBank = dataBank,
      dataKey = dataKey,
      contents = nil,
      displayNameToId = {}
    }

    function self.Update()
      if(not self.dataBank.hasKey(self.dataKey)) then
        DebugPrint("ContainerData: " .. self.dataKey .. " does not exist in databank")
        return
      end

      local dataString = self.dataBank.getStringValue(self.dataKey)
      if(not dataString) then
        DebugPrint("ContainerData: " .. self.dataKey .. " returned empty string")
        return
      end

      self.contents = {}
      self.displayNameToId = {}
      local contents = json.decode(dataString)
      for k, v in pairs(contents) do
        local displayName = system.getItem(v.id).displayName
        self.displayNameToId[displayName] = v.id
        self.contents[v.id] = v
      end
    end

    function self.GetQuantityForId(id)
      if(not self.contents) then
        DebugPrint("ContainerData: " .. self.dataKey .. " no contents")
        return ""
      end

      if(self.contents[i] == nil) then
        DebugPrint("ContainerData.GetQuanityForId: not content found for id" .. id)
        return 0.0
      end

      return self.contents[id].quantity
    end

    function self.GetQuantityForName(name)
      local id = self.displayNameToId[name]
      if(id == nil) then
        DebugPrint("ContainerData.GetQuantityForName: could not find id for name " .. name)
        return 0.0
      end

      local data = self.contents[id]
      if(data == nil or data.quantity == nil) then
        DebugPrint("ContainerData.GetQuantityForname: could not find data for name " .. name)
        return 0.0
      end

      return data.quantity
    end

    return self
  end
end


