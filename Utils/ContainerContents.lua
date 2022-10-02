require "./DuElements.lua"

if not ContainerContents then
  ContainerContents = {}
  ContainerContents.__index = ContainerContents

  function ContainerContents(container)
    self = {
        contents = {}
    }
        
    for k, v in pairs(container.getContent()) do
      self.contents[#self.contents + 1] = {
        id = v["id"], 
        name = system.getItem(v["id"])["displayName"], 
        quantity = v["quantity"]
      }
    end

    function self.GetQuantity(name)
      for k, v in self do
        if(v["name"] == name) then
          return v["quantity"]
        end
      end
    end
        
    function self.GetContents()
      return self.contents
    end
        
    return self
  end
end