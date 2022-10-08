require "../Utils/DUDebug.lua"

if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  function IndustryStocker(name, resourceMapper, industryUnit, outputContents, items)
    local self = {
      name = name,
      industryUnit = industryUnit,
      itemNameAndRequestedQuantity = items,
      outputContents = outputContents,
      resourceMapper = resourceMapper
    }
        
    function self.Update()
      if(IndustryState[self.industryUnit.getState()] ~= "Running") then
        for itemName, itemQuantity in pairs(self.itemNameAndRequestedQuantity) do
          local quantity = outputContents.GetQuantityForName(itemName)
          local requested = self.itemNameAndRequestedQuantity[itemName]
          DebugPrint(self.name .. ": quantity(" .. quantity .. ") < requested(" .. requested .. ")")
          if(quantity < requested) then
            DebugPrint(self.name .. ": Setting product to: " .. itemName)
            self.industryUnit.setOutput(self.resourceMapper.GetId(itemName))
            self.industryUnit.startFor(1)
          end
        end
      end
    end

    return self
  end
end


