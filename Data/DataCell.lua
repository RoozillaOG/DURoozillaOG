--- Single cell of text and associated status used for highlighting
-- @classmod DataCell

if not DataCell then
  DataCell = {}
  DataCell.__index = DataCell

  --- Normal Status
  -- @field DataCellStatusNormal
  DataCellStatusNormal = "Normal"

  --- Warning Status
  -- @field DataCellStatusWarning
  DataCellStatusWarning = "Warning"

  --- Alert Status
  -- @field DataCellStatusAlert
  DataCellStatusAlert = "Alert"

  --- All Good Status
  -- @field DataCellStatusGood
  DataCellStatusGood = "Good"

  --- A single cell of data 
  ---@param text string The text to store in the cell
  ---@param status string The status of the cell, one of
  --        DataCellStatusNormal
  --        DataCellStatusWarning
  --        DataCellStatusAlert
  --        DataCellStatusGood
  function DataCell(text, status)
    local self = {
      classname = "DataCell",
      ["data"] = {
        text = text,
        status = status or DataCellStatusNormal
      }
    }

    --- Return the text of the cell
    -- @return string The text
    function self.GetText()
      return self.data.text
    end

    --- Set the text of the cell
    ---@param value string The text
    function self.SetText(value)
      self.data.text = value
    end

    --- Return the notification status of the cell
    -- @return string The status, one of
    --        DataCellStatusNormal
    --        DataCellStatusWarning
    --        DataCellStatusAlert
    --        DataCellStatusGood
    function self.GetNotification()
      return self.data.status
    end

    --- Set the status of the cell, used for highlighting
    ---@param status string The status to set, one of
    --        DataCellStatusNormal
    --        DataCellStatusWarning
    --        DataCellStatusAlert
    --        DataCellStatusGood
    function self.SetNotification(status)
      self.data.status = status
    end

    --- Returns the data object containing text and status
    -- @return table The table of text and status
    function self.GetData()
      return self.data
    end
    
    --- The classname
    -- @return string Name of this class
    function self.GetClassName()
      return self.classname
    end

    return self
  end
end


