
require "dkjson"

if not ContainerMonitor then
  ContainerMonitor = {}
  ContainerMonitor.__index = ContainerMonitor

  function ContainerMonitor(containerName, container, dataBank) 
    local self = {
      container = container,
      dataBank = dataBank,
      containerName = containerName,
      dataBankKey = (containerName .. ".Data")
    }

    function self.Update()
      self.container.updateContent()
      local contents = self.container.getContent()
      if(contents) then
        self.dataBank.setStringValue(self.dataBankKey, json.encode(contents))
      end
    end

    function self.GetContainer()
      return self.container
    end
            
    function self.GetContainerName()
      return self.containerName
    end

    function self.GetContent()
      if(self.dataBank.hasKey(self.dataBankKey)) then
        return self.dataBank.getStringValue(self.dataBankKey)
      end
      return {}
    end
        
    function self.GetDataBankKey()
      return self.dataBankKey     
    end

    return self
  end

end


