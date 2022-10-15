
if not DUDebug then
  DUDebug = {}
  DUDebug.__index = DUDebug
    
  gDebugPrint = true --export: Enable or Display Debug Printing

  function DebugPrint(message)
    if(gDebugPrint) then
      system.print(message)
    end
  end
end


