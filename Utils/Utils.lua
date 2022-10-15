if not Utils then
  function UtilsShorten(str, length)
    if(#str > length) then
      return string.sub(str, 1, length)
    end

    return str
  end
end
