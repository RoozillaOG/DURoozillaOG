
if not MetalWorks then
  MetalWorks = {}
  MetalWorks.__index = MetalWorks

  function MetalWorks()
    local self = {
      idToDisplayName = {

      },
      displayNameToId = {

      }
    }

    function self.GetId(displayName)
      if(self.displayNameToId[displayName]) then
        return self.displayNameToId[displayName].id
      end
      return -1
    end

    function self.GetDisplayName(id)
      if(self.idToDisplayName[id]) then
        return self.idToDisplayName[id].displayNameWithSize
      end

      local item = system.getItem(id)
      if(item and item.displayNameWithSize) then
        system.print("PureResources::GetDisplayName(" .. id .. ") had to bail back to system call for " .. item.displayNameWithSize)
        return item.displayNameWithSize
      end

      system.print("PureResource::GetDisplayName(" .. id .. ") failed to get name")
      return ""
    end
  end
end

