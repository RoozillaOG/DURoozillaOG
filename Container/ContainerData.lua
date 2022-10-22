--- Used to read container contents from a DataBank populated by ContainerMonitor
-- @classmod ContainerData
require "dkjson"
require "../Utils/DUDebug.lua"

if not ContainerData then
  ContainerData = {}
  ContainerData.__index = ContainerData

  --- Creates a new ContainerData object
  ---@param dataBank DU::DataBank reference from a slot to a DataBank in PB
  ---@param dataKey string used to read from the DataBank

  function ContainerData(dataBank, dataKey)
    local self = {
      dataBank = dataBank,
      dataKey = dataKey,
      contents = nil,
      displayNameToId = {}
    }

    --- Update object data from DataBank contents
    -- @return none

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

    --- Returns quantity of an item by id
    ---@param id number The id of the item to retrieve quantity for
    -- @return number that is the quanity of the item

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

    --- Return quantity of an item by Display Name
    ---@param name string The name of the item to retrieve quantity for
    -- @return number that is the quanity of the item

    function self.GetQuantityForName(name)
      local id = self.displayNameToId[name]
      if(id == nil) then
        DebugPrint("ContainerData.GetQuantityForName: could not find id for name ")
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


