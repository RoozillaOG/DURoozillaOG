
if not DataCell then
  DataCell = {}
  DataCell.__index = DataCell

  DataCellStatusNormal = "Normal"
  DataCellStatusWarning = "Warning"
  DataCellStatusAlert = "Alert"
  DataCellStatusGood = "Good"

  --@param status string one of Normal, Warning, Alert
  function DataCell(text, status)
    local self = {
      classname = "DataCell",
      ["data"] = {
        text = text,
        status = status or DataCellStatusNormal
      }
    }

    function self.GetText()
      return self.data.text
    end

    function self.GetStatus()
      return self.data.status
    end

    function self.SetText(value)
      self.data.text = value
    end

    function self.SetStatus(status)
      self.data.status = status
    end
        
    function self.GetNotification()
      return self.data.status
    end

    function self.GetData()
      return self.data
    end
        
    function self.GetClassName()
      return self.classname
    end

    return self
  end
end


