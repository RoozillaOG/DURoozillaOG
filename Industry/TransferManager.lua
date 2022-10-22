
--- Transfer items automatically from an input container to an output container
-- It checks an input container for contents and attempts to set the transfer unit
-- to transfer to the output container it is linked to.
-- @classmod TransferManager

json = require "dkjson"
require "../Utils/DUDebug.lua"
require "../Industry/IndustryState.lua"

if not TransferManager then
  TransferManager = {}
  TransferManager.__index = TransferManager

  --- Return a new TransferManager object
  ---@param transferUnit DU::Industry The transfer unit DU Industry object
  ---@param inputContainer DU::Container The input container to transfer contents from
  function TransferManager(transferUnit, inputContainer)
    local self = {
      transferUnit = transferUnit,
      inputContainer = inputContainer,
      contents = json.decode(inputContainer.GetContent()),
      currentIndex = 1,
      currentTransfer = ""
    }

    --- Get the current items being transfered
    -- @return string The current item being transfered
    function self.GetCurrentTransfer() 
      return self.currentTransfer
    end

    --- Updates the states and changes transfer item as needed
    function self.Update()
      if(self.contents == nil or #self.contents < 1) then
        DebugPrint("Input contents empty")
        self.currentIndex = 1
        self.transferUnit.stop(true, true)
        self.contents = json.decode(self.inputContainer.GetContent())
        return
      end
            
      if(#self.contents < self.currentIndex) then
        DebugPrint("Resetting index and getting new contents")
        self.contents = json.decode(self.inputContainer.GetContent())
        self.currentIndex = 1
      end
            
            DebugPrint("stuff: " .. json.encode(self.contents))

      if(IndustryState[self.transferUnit.getState()] ~= "Running") then
        self.transferUnit.stop(true, true)
        DebugPrint("Index: " .. self.currentIndex)
        DebugPrint("Transfering: " .. json.encode(self.contents[self.currentIndex]))
        DebugPrint("Transfering: " .. system.getItem(self.contents[self.currentIndex].id).displayName)
        self.currentTransfer = system.getItem(self.contents[self.currentIndex].id).displayName
        self.transferUnit.setOutput(self.contents[self.currentIndex].id)
        self.transferUnit.startFor(1)
        self.currentIndex = self.currentIndex + 1
        return
      end
    end

    return self
  end
end


