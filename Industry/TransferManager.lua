
require "dkjson"
require "../Utils/DUDebug.lua"
require "../Industry/IndustryState.lua"

if not TransferManager then
  TransferManager = {}
  TransferManager.__index = TransferManager

  function TransferManager(transferUnit, inputContainer)
    local self = {
      transferUnit = transferUnit,
      inputContainer = inputContainer,
      contents = inputContainer.getContent() or {},
      currentIndex = 1,
      current = ""
    }

    function self.Update()
      if(self.contents == nil or #self.contents < 1) then
        DebugPrint("Input contents empty")
        self.currentIndex = 1
        self.transferUnit.stop(true, true)
        self.contents = self.inputContainer.getContent()
        return
      end
      if(#self.contents < self.currentIndex) then
        DebugPrint("Resetting index and getting new contents")
        self.contents = self.inputContainer.getContent()
        self.currentIndex = 1
      end
      DebugPrint("--------")
      DebugPrint("Input container contents: " .. json.encode(self.contents))
      DebugPrint("--------")
      if(IndustryState[self.transferUnit.getState()] ~= "Running") then
        local current = nil
        if(self.transferUnit.getOutputs()[1]) then
          current = self.transferUnit.getInputs()[1].id
          DebugPrint("Current: " .. current)
        end
        DebugPrint("State: " .. IndustryState[self.transferUnit.getState()])
        if(current ~= nil and IndustryState[self.transferUnit.getState()] == "Stopped") then
          DebugPrint("Continuing to transfer " .. system.getItem(self.transferUnit.getOutputs()[1].id).displayName)
          self.transferUnit.setOutput(current)
          self.transferUnit.startFor(1) 
        else
          self.transferUnit.stop(true, true)
          DebugPrint("Index: " .. self.currentIndex)
          DebugPrint("Transfering: " .. json.encode(self.contents[self.currentIndex]))
          DebugPrint("Transfering: " .. system.getItem(self.contents[self.currentIndex].id).displayName)
          self.transferUnit.setOutput(self.contents[self.currentIndex].id)
          self.transferUnit.startFor(1)
          self.currentIndex = self.currentIndex + 1
          return
        end
      end
    end

    return self
  end
end


