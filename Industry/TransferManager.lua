
require "dkjson"
require "../Utils/DUDebug.lua"
require "../Industry/IndustryState.lua"

if not TransferManager then
  TransferManager = {}
  TransferManager.__index = TransferManager

  function TransferManager(transferUnit, inputContainer)
    local self = {
      transferUnit = transferUnit,
      inputContainer = inputContainer
    }

    function self.Update()
      local contents = inputContainer.getContent()
      inputContainer.updateContent()
      DebugPrint("--------")
      DebugPrint("Input container contents: " .. json.encode(contents))
      DebugPrint("--------")
      if(IndustryState[self.transferUnit.getState()] ~= "Running") then
        local current = nil
        if(self.transferUnit.getOutputs()[1]) then
          current = self.resourceMapper.GetDisplayName(self.transferUnit.getInputs()[1].id)
        end
        self.transferUnit.stop(true, true)
        for itemName, itemValue in pairs(self.inputContainer.getContent()) do
          self.transferUnit.setOutput(itemValue.id)
          self.transferUnit.startFor(1)
        end
      end
    end

    return self
  end
end


