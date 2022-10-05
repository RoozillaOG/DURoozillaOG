
if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  function IndustryStocker(resourceMapper, industryUnit, outputContents, items)
    local self = {
      industryUnit = industryUnit,
      itemNameAndRequestedQuantity = items,
      outputContents = outputContents,
      resourceMapper = resourceMapper
    }
        
    function self.Update()
      if(IndustryState[industryUnit.getState()] ~= "Running") then
        for itemName, itemQuantity in pairs(self.itemNameAndRequestedQuantity) do
          local quantity = outputContents.GetQuantityForName(itemName)
          if(quantity < self.itemNameAndRequestedQuantity[itemName]) then
            system.print("Setting product to: " .. itemName)
            self.industryUnit.setOutput(self.resourceMapper.GetId(itemName))
            self.industryUnit.stop(true, true)
            self.industryUnit.startFor(1)
          end
        end
      end
    end
    return self
  end
end


