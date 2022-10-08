require "./ColorRGBA.lua"

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

    function self.GetData()
      return self.data
    end

    return self
  end
end