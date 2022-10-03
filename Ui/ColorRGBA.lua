
if not ColorRGBA then
  ColorRGBA = {}
  ColorRGBA.__index = ColorRGBA

  function ColorRGBA(r, g, b, a)
    local self = {
      r = r or 0,
      g = g or 0,
      b = b or 0,
      a = a or 1.0
    }

    function self.LightGreen() return ColorRGBA(0.0, 0.3, 0.0, 0.3) end
    function self.LightRed() return ColorRGBA(0.3, 0.0, 0.0, 0.3) end
    function self.LightBlue() return ColorRGBA(0.0, 0.0, 0.3, 0.3) end
    function self.White() return ColorRGBA(0.7, 0.7, 0.7, 0.8) end
    function self.Black() return ColorRGBA(0.0, 0.0, 0.0, 0.8) end

    return self
  end
end


