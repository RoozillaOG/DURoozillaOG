
--- ElectronicsProducts class used to map to/from id and Display Name
-- @classmod ElectronicsProducts

if not ElectronicProducts then
  ElectronicProducts = {}
  ElectronicProducts.__index = ElectronicProducts

  --- ElectronicProducts
  -- Creates a new instance of the ElectronicProducts class
  function ElectronicProducts()
    local self = {
      idToDisplayName = {
        [794666751] = { id = 794666751, displayNameWithSize = "Advanced Component" },
         [794666749] = { id = 794666749, displayNameWithSize = "Basic Component" },
         [794666748] = { id = 794666748, displayNameWithSize = "Uncommon Component" },
         [2872711781] = { id = 2872711781, displayNameWithSize = "Advanced Connector" },
         [2872711779] = { id = 2872711779, displayNameWithSize = "Basic Connector" },
         [2917319456] = { id = 2917319456, displayNameWithSize = "Pipe Connector m" },
         [2872711778] = { id = 2872711778, displayNameWithSize = "Uncommon Connector" },
         [1297540452] = { id = 1297540452, displayNameWithSize = "Advanced Electronics" },
         [2861848557] = { id = 2861848557, displayNameWithSize = "Advanced Electronics Industry m" },
         [1297540454] = { id = 1297540454, displayNameWithSize = "Basic Electronics" },
         [2702446443] = { id = 2702446443, displayNameWithSize = "Basic Electronics industry m" },
         [1417512119] = { id = 1417512119, displayNameWithSize = "Deprecated electronic Elements industry" },
         [1297540450] = { id = 1297540450, displayNameWithSize = "Exotic Electronics" },
         [1297540451] = { id = 1297540451, displayNameWithSize = "Rare Electronics" },
         [2861848556] = { id = 2861848556, displayNameWithSize = "Rare Electronics Industry m" },
         [1297540453] = { id = 1297540453, displayNameWithSize = "Uncommon Electronics" },
         [2861848558] = { id = 2861848558, displayNameWithSize = "Uncommon Electronics Industry m" },

      },
      displayNameToId = {
        ["Advanced Component"] = { id = 794666751, displayNameWithSize = "Advanced Component" },
         ["Basic Component"] = { id = 794666749, displayNameWithSize = "Basic Component" },
         ["Uncommon Component"] = { id = 794666748, displayNameWithSize = "Uncommon Component" },
         ["Advanced Connector"] = { id = 2872711781, displayNameWithSize = "Advanced Connector" },
         ["Basic Connector"] = { id = 2872711779, displayNameWithSize = "Basic Connector" },
         ["Pipe Connector m"] = { id = 2917319456, displayNameWithSize = "Pipe Connector m" },
         ["Uncommon Connector"] = { id = 2872711778, displayNameWithSize = "Uncommon Connector" },
         ["Advanced Electronics"] = { id = 1297540452, displayNameWithSize = "Advanced Electronics" },
         ["Advanced Electronics Industry m"] = { id = 2861848557, displayNameWithSize = "Advanced Electronics Industry m" },
         ["Basic Electronics"] = { id = 1297540454, displayNameWithSize = "Basic Electronics" },
         ["Basic Electronics industry m"] = { id = 2702446443, displayNameWithSize = "Basic Electronics industry m" },
         ["Deprecated electronic Elements industry"] = { id = 1417512119, displayNameWithSize = "Deprecated electronic Elements industry" },
         ["Exotic Electronics"] = { id = 1297540450, displayNameWithSize = "Exotic Electronics" },
         ["Rare Electronics"] = { id = 1297540451, displayNameWithSize = "Rare Electronics" },
         ["Rare Electronics Industry m"] = { id = 2861848556, displayNameWithSize = "Rare Electronics Industry m" },
         ["Uncommon Electronics"] = { id = 1297540453, displayNameWithSize = "Uncommon Electronics" },
         ["Uncommon Electronics Industry m"] = { id = 2861848558, displayNameWithSize = "Uncommon Electronics Industry m" },

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
    
    return self
  end
end


