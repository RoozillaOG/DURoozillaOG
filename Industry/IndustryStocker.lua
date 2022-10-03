
if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  function IndustryStocker(resourceMapper, industryUnit, outputContainer, items)
    local self = {
      industryUnit = industryUnit,
      itemNameAndRequestedQuantity = items,
      outputContainer = outputContainer,
      resourceMapper = resourceMapper
    }
        
    function self.Update()
      local outputContainer = ContainerContents({self.outputContainer})
      local state = self.industryUnit.getState()
      local inputItemName = self.resourceMapper.GetDisplayName(self.industryUnit.getInputs()[1].id)
      local outputItemName = self.resourceMapper.GetDisplayName(self.industryUnit.getOutputs()[1].id)
      
      if(IndustryState[industryUnit.getState()] ~= "Running") then
        for itemName, itemQuantity in pairs(self.itemNameAndRequestedQuantity) do
          if(itemName ~= outputItemName) then
            local quantity = outputContainer.GetQuantity(self.resourceMapper.Get)
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


