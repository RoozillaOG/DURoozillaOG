require "RooUtils.lua"

if not UiTable then
  UiTable = {}
  UiTable.__index = UiTable

  function UiTable:new()
    local self = {
    }
    
    return self
  end
end