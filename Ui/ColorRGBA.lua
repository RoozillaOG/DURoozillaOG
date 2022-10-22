--- Color class red, green, blue, alpha with some predefines
-- @classmod ColorRGBA

if not ColorRGBA then
  ColorRGBA = {}
  ColorRGBA.__index = ColorRGBA

  --- Color table for r,g,b,a
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
    
  --- Light Green
  -- @field ColorRGBALightGreen
  ColorRGBALightGreen = ColorRGBA(0.0, 0.3, 0.0, 0.3)

  --- Light Red
  -- @field ColorRGBALightRed
  ColorRGBALightRed = ColorRGBA(0.3, 0.0, 0.0, 0.3)

  --- Light Blue
  -- @field ColorRGBALightBlue
  ColorRGBALightBlue = ColorRGBA(0.0, 0.0, 0.3, 0.3)

  --- Light Yellow
  -- @field ColorRGBALightYellow
  ColorRGBALightYellow = ColorRGBA(0.9, 0.7, 0.0, 0.3)

  --- White
  -- @field ColorRGBAWhite
  ColorRGBAWhite = ColorRGBA(0.7, 0.7, 0.7, 0.8)

  --- Black
  -- @field ColorRGBABlack
  ColorRGBABlack = ColorRGBA(0.0, 0.0, 0.0, 0.8) 
    
end


