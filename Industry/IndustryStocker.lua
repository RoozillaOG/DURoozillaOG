
if not IndustryStocker then
  IndustryStocker = {}
  IndustryStocker.__index = IndustryStocker

  function IndustryStocker(refiner, outputContainer, items)
    local self = {
      refiner = refiner,
      itemNameAndRequestedQuantity = items,
      itemIdToName = {},
      itemNameToId = {},
      outputContainer = outputContainer
    }
      
    local contents = ContainerContents({self.outputContainer}).GetContents()
    for ik, iv in pairs(items) do
      for ek, ev in pairs(contents) do
        local name = system.getItem(ev.id).name
        if(name == ik) then
          self.itemIdToName[ev.id] = name
          self.itemNameToId[name] = ev.id
        end
      end
    end
        
    --system.print("itemIdtoName: " .. json.encode(self.itemIdToName))
        
    function self.Update()
      local outputContainer = ContainerContents({self.outputContainer})
      local state = self.refiner.getState()
      --system.print("State = " .. IndustryState[state])
            
      --system.print("Refiner Inputs: " .. json.encode(self.refiner.getInputs()))
      local inputItem = system.getItem(self.refiner.getInputs()[1]["id"])
            
      --system.print("Refiner Outputs: " .. json.encode(self.refiner.getOutputs()))
      local outputItem = system.getItem(self.refiner.getOutputs()[1]["id"])
      
      if(IndustryState[refiner.getState()] == "Running") then
        system.print("Refinery currently running")
      else
        for k, v in pairs(self.itemNameAndRequestedQuantity) do
                    system.print("v = " .. v)
          if(k ~= outputItem) then
            local quantity = outputContainer.GetQuantity(self.itemNameToId[k])
            system.print(k .. ": quantity < requested " .. quantity .. "<" .. v)
            if(quantity < v) then
              self.refiner.setOutput(self.itemNameToId[k])
              self.refiner.startFor(1)
            end
          end
        end
      end
      
    end

    return self
  end
end


