
if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  function IndustryStocker(resourceMapper, industryUnit, outputContainers, items)
    local self = {
      industryUnit = industryUnit,
      itemNameAndRequestedQuantity = items,
      outputContainers = outputContainers,
      resourceMapper = resourceMapper
    }
        
    function self.Update()
      local outputContainer = ContainerContents(self.resourceMapper, self.outputContainers)
      local state = self.industryUnit.getState()
      system.print("IndustryStocker::Update(" .. self.industryUnit.getOutputs()[1].id .. ")")
      local outputItemName = self.resourceMapper.GetDisplayName(self.industryUnit.getOutputs()[1].id)
      
      if(IndustryState[industryUnit.getState()] ~= "Running") then
        for itemName, itemQuantity in pairs(self.itemNameAndRequestedQuantity) do
          if(itemName ~= outputItemName) then
            local quantity = outputContainer.GetQuantityForName(itemName)
            system.print("Compare: quantity < itemQuantity" .. quantity .. " < " .. itemQuantity)
            if(quantity < itemQuantity) then
              self.industryUnit.setOutput(self.resourceMapper.GetId(itemName))
              self.industryUnit.startFor(1)
            end
          end
        end
      end
    end
    return self
  end
end


