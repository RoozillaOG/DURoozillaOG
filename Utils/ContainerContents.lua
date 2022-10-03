
require "./DuElements.lua"

if not ContainerContents then
  ContainerContents = {}
  ContainerContents.__index = ContainerContents

  function ContainerContents(containers)
    self = {
        contents = {}
    }
        
    --system.print(json.encode(container.getContent()))
    for ck, vc in pairs(containers) do
      system.print("Container: " .. ck)

      for k, v in pairs(containers[ck].getContent()) do
        local item = system.getItem(v.id)
        system.print("  Item = " .. item.name)
 
        if(self.contents[item.name]) then
          system.print("Updating existing quantity")
          self.contents[item.name]["quantity"] = self.contents[item.name]["quantity"] + v["quantity"]     
        else
          self.contents[item.name] = {
            displayName = system.getItem(v["id"])["displayName"],
            id = v["id"], 
            quantity = v["quantity"]
          }
        end
            
      --system.print(json.encode(self.contents[#self.contents]))
      end
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


