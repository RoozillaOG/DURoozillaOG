--- Parts class used to map to/from id and Display Name
-- @classmod Parts

if not Parts then
  Parts = {}
  Parts.__index = Parts

  --- Parts Constructor
  -- Creates a new instance of the Parts class
  function Parts()
    local self = {
      idToDisplayName = {
        [1331181089] = { id = 1331181089, displayNameWithSize = "Advanced hydraulics" },
         [1331181119] = { id = 1331181119, displayNameWithSize = "Basic hydraulics" },
         [1331181091] = { id = 1331181091, displayNameWithSize = "Exotic hydraulics" },
         [1331181088] = { id = 1331181088, displayNameWithSize = "Rare hydraulics" },
         [1331181118] = { id = 1331181118, displayNameWithSize = "Uncommon hydraulics" },

      },
      displayNameToId = {
        ["Advanced hydraulics"] = { id = 1331181089, displayNameWithSize = "Advanced hydraulics" },
        ["Basic hydraulics"] = { id = 1331181119, displayNameWithSize = "Basic hydraulics" },
        ["Exotic hydraulics"] = { id = 1331181091, displayNameWithSize = "Exotic hydraulics" },
        ["Rare hydraulics"] = { id = 1331181088, displayNameWithSize = "Rare hydraulics" },
        ["Uncommon hydraulics"] = { id = 1331181118, displayNameWithSize = "Uncommon hydraulics" }

      }
    }

    --- GetId
    -- Maps display name to id. Returns -1 if display name was not in the table.
    ---@param displayName string the display name to retrieve id for
    -- @return an id that represents the element
    function self.GetId(displayName)
      if(self.displayNameToId[displayName]) then
        return self.displayNameToId[displayName].id
      end
      return -1
    end

    --- GetDisplayName
    -- Maps id to display name. Will call system.getItem() if necessary.
    ---@param id number the id to retrieve display name for
    -- @return a string that is the Display Name of the item
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

