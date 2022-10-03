
if not ContainerContents then
  ContainerContents = {}
  ContainerContents.__index = ContainerContents

  function ContainerContents(resourceMapper, containers)
    self = {
        contents = {},
        resourceMapper = resourceMapper
    }

    for containerIndex, containerValue in pairs(containers) do
      system.print("Container: " .. containerIndex)
      for itemKey, itemValue in pairs(containerValue.getContent()) do
        system.print("item = " .. json.encode(itemValue))
        local itemName = self.resourceMapper.GetDisplayName(itemValue.id)
        if(self.contents[itemName]) then
          self.contents[itemName]["quantity"] = self.contents[itemName].quantity + itemValue.quantity    
        else
          self.contents[itemName] = {
            displayName = itemName,
            id = itemValue.id, 
            quantity = itemValue.quantity
          }
        end
      end
    end

    function self.GetQuantityForId(id)
      local name = self.resourceMapper.GetDisplayName(id)
      if(name and self.contents[name]) then
        return self.contents[name].quantity
      end
      return 0
    end

    function self.GetQuantityForName(name)
      if(name and self.contents[name]) then
        return self.contents[name].quantity
      end
      return 0
    end

    function self.GetContents()
      return self.contents
    end

    return self
  end
end


