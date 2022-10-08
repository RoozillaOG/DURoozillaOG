
if not DataCell then
  DataCell = {}
  DataCell.__index = DataCell

  DataCellStatusNormal = 1
  DataCellStatusWarning = 2
  DataCellStatusAlert = 3
  DataCellStatusGood = 4

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


