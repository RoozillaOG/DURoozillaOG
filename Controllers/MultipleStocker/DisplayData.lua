--- DisplayData for the MultipleStocker system
-- Contains the data to pass to/from the PB and the Display unit
-- @classmod MultipleStocker.DisplayData

require "dkjson"
require "../../Data/DataCell.lua"
require "../../Data/DataRow.lua"
require "../../Data/DataGrid.lua"
require "../../Utils/Utils.lua"

if not DisplayData then
  DisplayData = {}
  DisplayData.__index = DisplayData

  --- Create a new DisplayData object
  ---@param stockers DUIndustry The list of Industry units used to mainatin stock
  ---@param containerData ContainerData that monitors the contents of the output container to determin when to restock
  ---@param display DUDisplay The DUDisplay unit to send data to 
  function DisplayData(stockers, containerData, display)
    local self = {
      stockers = stockers,
      display = display,
      containerData = containerData
    }

    --- Update the DisplayData based on current state and post to display via setScriptInput()
    function self.Update()
      local dataGrid = DataGrid()
      local displayData = {}

      for k, v in pairs(self.stockers) do
        local row = DataRow()
        local stateName = v.GetStateName()
        local notification = DataCellStatusNormal
        if(stateName == "Stopped") then
          notification = DataCellStatusNormal
        elseif (stateName == "Running") then
          notification = DataCellStatusGood
        else
          notification = DataCellStatusAlert
        end

        row.AddCell(DataCell(UtilsShorten(v.GetName(), 10), notification))
        row.AddCell(DataCell(UtilsShorten(v.GetCurrentItem(), 10), notification))
        row.AddCell(DataCell(
                        math.floor(self.containerData.GetQuantityForName(v.GetCurrentItem())), 
                       notification)
                    )
        row.AddCell(DataCell(v.GetStateId(), notification))
        dataGrid.AddRow(row)
      end

      local jsonString = dataGrid.Encode()
      DebugPrint("DisplayData: setting data = " .. jsonString)
      self.display.setScriptInput(jsonString)
    end

    return self
  end
end


