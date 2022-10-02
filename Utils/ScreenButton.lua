require "Utils.lua"

-- button class
if not ScreenButton then
  ScreenButton = {}
  ScreenButton.__index = ScreenButton

  function Button:new(x, y, width, length, label)
    local self = {
      x = x or 0,
      y = y or 0,
      l = length or 100,
      w = width or 20,
      label = label or "",
      color = { 1, 1, 1 }
    }

    function self:draw(layer, font)

    end

    return self
  end

end
