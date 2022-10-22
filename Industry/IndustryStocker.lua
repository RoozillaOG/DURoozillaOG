
--- Keeps item in a given list stocked in a given output containerData
-- @classmod IndustryStocker

require "../Utils/DUDebug.lua"

if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  --- Create a new IndustryStocker
  ---@param name string The name of the stocker
  ---@param resourceMapper resourceObject The resource object that maps id to DisplayName
  -- @see PureResource.lua
  ---@param industryUnit DU::Industry The DU Industry object to stock
  ---@param containerData ContainerData The ContainerData object to use to monitor current level of items
  ---@param items table The table of display name -> desired quantity to determine when to restock
  function IndustryStocker(name, resourceMapper, industryUnit, containerData, items)
    local self = {
      name = name,
      industryUnit = industryUnit,
      itemNameAndRequestedQuantity = items,
      resourceMapper = resourceMapper,
      containerData = containerData,
      currentItem = ""
    }
    
    --- Update the state of the stocker, selecting a new output if needed
    function self.Update()
      DebugPrint("IndustryStocker: Update(): " .. self.name)
      if(IndustryState[self.industryUnit.getState()] ~= "Running") then
        local current = nil
        if(self.industryUnit.getOutputs()[1]) then
          current = self.resourceMapper.GetDisplayName(self.industryUnit.getOutputs()[1].id)
        end
        self.industryUnit.stop(true, true)
        for itemName, itemQuantity in pairs(self.itemNameAndRequestedQuantity) do
          local quantity = self.containerData.GetQuantityForName(itemName)
          local requested = self.itemNameAndRequestedQuantity[itemName]
          DebugPrint(self.name .. ": quantity(" .. quantity .. ") < requested(" .. requested .. ")" .. " " .. itemName .. " ~= " .. current)
          if(quantity < requested and current ~= itemName) then
            DebugPrint(self.name .. ": Setting product to: " .. itemName)
            self.industryUnit.setOutput(self.resourceMapper.GetId(itemName))
            self.currentItem = itemName
            self.industryUnit.startFor(1)
          end
        end
      end
    end

    --- Get the name of the current state of the DU::Industry
    -- @return string The state name (i.e. Running)
    function self.GetStateName()
      return IndustryState[self.industryUnit.getState()]
    end

    --- Get the state id
    -- @return number The state number
    function self.GetStateId()
      return self.industryUnit.getState()
    end
    
    --- Get the name of the stocker
    -- @return string The name of the stocker
    function self.GetName()
      return self.name or ""
    end

    --- Get the current item set in the Industry
    -- @return string The display name of the item currently being produced by Industry object
    function self.GetCurrentItem()
      local output = self.industryUnit.getOutputs()
      if(output == nil or #output == 0) then
        return ""
      end
      return system.getItem(output[1].id).displayName
    end

    return self
  end
end


