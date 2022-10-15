

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
      containerData = containerData
    }
        
    function self.Update()
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
            self.industryUnit.startFor(1)
          end
        end
      end
    end

    return self
  end
end


