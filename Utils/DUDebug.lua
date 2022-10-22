
--- DUDebug
-- Provides functions usefull for debugging
-- @module DUDebug

if not DUDebug then
  DUDebug = {}
  DUDebug.__index = DUDebug
    
  gDebugPrint = true --export: Enable or Display Debug Printing

  --- DebugPrint
  -- Used to print to lua channel, bool on whether to print or not is
  -- exported to be available in the advanced menu of the PB
  ---@param message string the message to display
  -- @return none
  function DebugPrint(message)
    if(gDebugPrint) then
      system.print(message)
    end
  end
end


