
if not IndustryData then
  IndustryData = {}
  IndustryData.__index = IndustryData

  function IndustryData()
    local self = {
      name = "",
      status = "",
      product = "",
      notification = ""
    }
    
    return self
  end
end


