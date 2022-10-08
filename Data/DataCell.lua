local json = require("dkjson") 

if not DataCell then
  DataCell = {}
  DataCell.__index = DataCell

  DataCellStatusNormal = "Normal"
  DataCellStatusWarning = "Warning"
  DataCellStatusAlert = "Alert"
  DataCellStatusGood = "Good"

  --@param status string one of Normal, Warning, Alert
  function DataCell(text, notification)
    local self = {
      ["data"] = {
        text = text or "",
        notification = notification or DataCellStatusNormal
      }
    }
        
    logMessage("Data = " .. json.encode(self.data))

    function self.GetText()
      return self.data.text
    end

    function self.GetNotification()
      return self.data.notification
    end

    function self.GetData()
      return self.data
    end

    return self
  end
end


