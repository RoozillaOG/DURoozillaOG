
--- Monitor a containers contents and update a DataBank key with json string
-- @classmod ContainerMonitor

require "dkjson"

if not ContainerMonitor then
  ContainerMonitor = {}
  ContainerMonitor.__index = ContainerMonitor

  --- Constructs a new ContainerMonitor for a given set of container and DataBank information
  ---@param containerName string The custom name of the container, corresponds to prefix of the key
  ---@param container DU::Container Container reference from slot in PB
  ---@param dataBank DU::DataBank Reference to DU::DataBank to a slot in PB
  function ContainerMonitor(containerName, container, dataBank) 
    local self = {
      container = container,
      dataBank = dataBank,
      containerName = containerName,
      dataBankKey = (containerName .. ".Data")
    }


    --- Update the container contents to DataBank
    -- @return none
    function self.Update()
      self.container.updateContent()
      local contents = self.container.getContent()
      if(contents) then
        self.dataBank.setStringValue(self.dataBankKey, json.encode(contents))
      end
    end

    --- Return the DU::Container object
    -- @return DU::Container object
    function self.GetContainer()
      return self.container
    end
            
    --- Return the container name
    -- @return string The container short name
    function self.GetContainerName()
      return self.containerName
    end

    --- Return the contents of the container
    -- @return string Json string representing the contents of the container
    function self.GetContent()
      if(self.dataBank.hasKey(self.dataBankKey)) then
        return self.dataBank.getStringValue(self.dataBankKey)
      end
      return {}
    end
        
    --- Return the key used to access the container information from DataBank
    -- @return string The database key can be used to retrieve by DU::DataBank.getStringValue()
    function self.GetDataBankKey()
      return self.dataBankKey     
    end

    return self
  end

end


