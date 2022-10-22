
--- Helper functions such as UtilsShorten to shorten a string
-- @module Utils

if not Utils then

  --- UtilsShorten
  -- Ensures a string is no longer than specified value
  ---@param str string the string to shorten if needed
  ---@param length number the maximum length of the string
  function UtilsShorten(str, length)
    DebugPrint("String length " .. #str)
    if(#str > length) then
      DebugPrint("New string " .. string.sub(str, 1, length))
      return string.sub(str, 1, length)
    end

    return str
  end
end


