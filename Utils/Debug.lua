
if not DUDebug then
  function print(message)
    if(DebugFlag) then
      system.print(message)
    end
  end
end