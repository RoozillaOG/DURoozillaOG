
if not Utils then
  function UtilsShorten(str, length)
    DebugPrint("String length " .. #str)
    if(#str > length) then
      DebugPrint("New string " .. string.sub(str, 1, length))
      return string.sub(str, 1, length)
    end

    return str
  end
end


