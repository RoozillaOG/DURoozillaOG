
require "../Utils/DUDebug.lua"

if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  function IndustryStocker(name, resourceMapper, industryUnit, containerData, items)
    local self = {
      name = name,
      industryUnit = industryUnit,
      itemNameAndRequestedQuantity = items,
      resourceMapper = resourceMapper,
      containerData = containerData,
      currentItem = ""
    }
        
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

    function self.GetStateName()
      return IndustryState[self.industryUnit.getState()]
    end

    function self.GetStateId()
      return self.industryUnit.getState()
    end
    
    function self.GetName()
      return self.name or ""
    end

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


