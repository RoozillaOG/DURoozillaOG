
if not DUDebug then
  function print(message)
    if(DebugPrint) then
      system.print(message)
    end
  end
end