
--- ThreeDPrinter class used to map to/from id and Display Name
-- @classmod ThreeDPrinter

if not ThreeDPrinter then
  ThreeDPrinter = {}
  ThreeDPrinter.__index = ThreeDPrinter

  --- ThreeDPrinter Constructor
  -- Creates a new instance of the ThreeDPrinter class
  function ThreeDPrinter()
    local self = {
      idToDisplayName = {
        [994058066] = { id = 994058066, displayNameWithSize = "Advanced Reinforced Frame l" },
         [994058069] = { id = 994058069, displayNameWithSize = "Advanced Reinforced Frame m" },
         [994058059] = { id = 994058059, displayNameWithSize = "Advanced Reinforced Frame s" },
         [1179601462] = { id = 1179601462, displayNameWithSize = "Advanced Reinforced Frame xl" },
         [1179601457] = { id = 1179601457, displayNameWithSize = "Advanced Reinforced Frame xs" },
         [1981362607] = { id = 1981362607, displayNameWithSize = "Advanced Standard Frame l" },
         [1981362606] = { id = 1981362606, displayNameWithSize = "Advanced Standard Frame m" },
         [1981363796] = { id = 1981363796, displayNameWithSize = "Advanced Standard Frame s" },
         [873622058] = { id = 873622058, displayNameWithSize = "Advanced Standard Frame xl" },
         [873622227] = { id = 873622227, displayNameWithSize = "Advanced Standard Frame xs" },
         [994058205] = { id = 994058205, displayNameWithSize = "Basic Reinforced Frame l" },
         [994058204] = { id = 994058204, displayNameWithSize = "Basic Reinforced Frame m" },
         [994058182] = { id = 994058182, displayNameWithSize = "Basic Reinforced Frame s" },
         [1179610516] = { id = 1179610516, displayNameWithSize = "Basic Reinforced Frame xl" },
         [1179610525] = { id = 1179610525, displayNameWithSize = "Basic Reinforced Frame xs" },
         [1981362474] = { id = 1981362474, displayNameWithSize = "Basic Standard Frame l" },
         [1981362473] = { id = 1981362473, displayNameWithSize = "Basic Standard Frame m" },
         [1981362643] = { id = 1981362643, displayNameWithSize = "Basic Standard Frame s" },
         [873663948] = { id = 873663948, displayNameWithSize = "Basic Standard Frame xl" },
         [873663991] = { id = 873663991, displayNameWithSize = "Basic Standard Frame xs" },
         [994057936] = { id = 994057936, displayNameWithSize = "Exotic Reinforced Frame l" },
         [994057943] = { id = 994057943, displayNameWithSize = "Exotic Reinforced Frame m" },
         [994057929] = { id = 994057929, displayNameWithSize = "Exotic Reinforced Frame s" },
         [1179593236] = { id = 1179593236, displayNameWithSize = "Exotic Reinforced Frame xl" },
         [1179593235] = { id = 1179593235, displayNameWithSize = "Exotic Reinforced Frame xs" },
         [1981363757] = { id = 1981363757, displayNameWithSize = "Exotic Standard Frame l" },
         [1981363756] = { id = 1981363756, displayNameWithSize = "Exotic Standard Frame m" },
         [1981363926] = { id = 1981363926, displayNameWithSize = "Exotic Standard Frame s" },
         [873614024] = { id = 873614024, displayNameWithSize = "Exotic Standard Frame xl" },
         [873614065] = { id = 873614065, displayNameWithSize = "Exotic Standard Frame xs" },
         [994058003] = { id = 994058003, displayNameWithSize = "Rare Reinforced Frame l" },
         [994058004] = { id = 994058004, displayNameWithSize = "Rare Reinforced Frame m" },
         [994057994] = { id = 994057994, displayNameWithSize = "Rare Reinforced Frame s" },
         [1179605671] = { id = 1179605671, displayNameWithSize = "Rare Reinforced Frame xl" },
         [1179605664] = { id = 1179605664, displayNameWithSize = "Rare Reinforced Frame xs" },
         [1981362670] = { id = 1981362670, displayNameWithSize = "Rare Standard Frame l" },
         [1981362671] = { id = 1981362671, displayNameWithSize = "Rare Standard Frame m" },
         [1981362581] = { id = 1981362581, displayNameWithSize = "Rare Standard Frame s" },
         [873667227] = { id = 873667227, displayNameWithSize = "Rare Standard Frame xl" },
         [873667202] = { id = 873667202, displayNameWithSize = "Rare Standard Frame xs" },
         [994058140] = { id = 994058140, displayNameWithSize = "Uncommon Reinforced Frame l" },
         [994058141] = { id = 994058141, displayNameWithSize = "Uncommon Reinforced Frame m" },
         [994058119] = { id = 994058119, displayNameWithSize = "Uncommon Reinforced Frame s" },
         [1179614597] = { id = 1179614597, displayNameWithSize = "Uncommon Reinforced Frame xl" },
         [1179614604] = { id = 1179614604, displayNameWithSize = "Uncommon Reinforced Frame xs" },
         [1981362539] = { id = 1981362539, displayNameWithSize = "Uncommon Standard Frame l" },
         [1981362536] = { id = 1981362536, displayNameWithSize = "Uncommon Standard Frame m" },
         [1981362450] = { id = 1981362450, displayNameWithSize = "Uncommon Standard Frame s" },
         [873676093] = { id = 873676093, displayNameWithSize = "Uncommon Standard Frame xl" },
         [873676070] = { id = 873676070, displayNameWithSize = "Uncommon Standard Frame xs" },

      },
      displayNameToId = {
        ["Advanced Reinforced Frame l"] = { id = 994058066, displayNameWithSize = "Advanced Reinforced Frame l" },
         ["Advanced Reinforced Frame m"] = { id = 994058069, displayNameWithSize = "Advanced Reinforced Frame m" },
         ["Advanced Reinforced Frame s"] = { id = 994058059, displayNameWithSize = "Advanced Reinforced Frame s" },
         ["Advanced Reinforced Frame xl"] = { id = 1179601462, displayNameWithSize = "Advanced Reinforced Frame xl" },
         ["Advanced Reinforced Frame xs"] = { id = 1179601457, displayNameWithSize = "Advanced Reinforced Frame xs" },
         ["Advanced Standard Frame l"] = { id = 1981362607, displayNameWithSize = "Advanced Standard Frame l" },
         ["Advanced Standard Frame m"] = { id = 1981362606, displayNameWithSize = "Advanced Standard Frame m" },
         ["Advanced Standard Frame s"] = { id = 1981363796, displayNameWithSize = "Advanced Standard Frame s" },
         ["Advanced Standard Frame xl"] = { id = 873622058, displayNameWithSize = "Advanced Standard Frame xl" },
         ["Advanced Standard Frame xs"] = { id = 873622227, displayNameWithSize = "Advanced Standard Frame xs" },
         ["Basic Reinforced Frame l"] = { id = 994058205, displayNameWithSize = "Basic Reinforced Frame l" },
         ["Basic Reinforced Frame m"] = { id = 994058204, displayNameWithSize = "Basic Reinforced Frame m" },
         ["Basic Reinforced Frame s"] = { id = 994058182, displayNameWithSize = "Basic Reinforced Frame s" },
         ["Basic Reinforced Frame xl"] = { id = 1179610516, displayNameWithSize = "Basic Reinforced Frame xl" },
         ["Basic Reinforced Frame xs"] = { id = 1179610525, displayNameWithSize = "Basic Reinforced Frame xs" },
         ["Basic Standard Frame l"] = { id = 1981362474, displayNameWithSize = "Basic Standard Frame l" },
         ["Basic Standard Frame m"] = { id = 1981362473, displayNameWithSize = "Basic Standard Frame m" },
         ["Basic Standard Frame s"] = { id = 1981362643, displayNameWithSize = "Basic Standard Frame s" },
         ["Basic Standard Frame xl"] = { id = 873663948, displayNameWithSize = "Basic Standard Frame xl" },
         ["Basic Standard Frame xs"] = { id = 873663991, displayNameWithSize = "Basic Standard Frame xs" },
         ["Exotic Reinforced Frame l"] = { id = 994057936, displayNameWithSize = "Exotic Reinforced Frame l" },
         ["Exotic Reinforced Frame m"] = { id = 994057943, displayNameWithSize = "Exotic Reinforced Frame m" },
         ["Exotic Reinforced Frame s"] = { id = 994057929, displayNameWithSize = "Exotic Reinforced Frame s" },
         ["Exotic Reinforced Frame xl"] = { id = 1179593236, displayNameWithSize = "Exotic Reinforced Frame xl" },
         ["Exotic Reinforced Frame xs"] = { id = 1179593235, displayNameWithSize = "Exotic Reinforced Frame xs" },
         ["Exotic Standard Frame l"] = { id = 1981363757, displayNameWithSize = "Exotic Standard Frame l" },
         ["Exotic Standard Frame m"] = { id = 1981363756, displayNameWithSize = "Exotic Standard Frame m" },
         ["Exotic Standard Frame s"] = { id = 1981363926, displayNameWithSize = "Exotic Standard Frame s" },
         ["Exotic Standard Frame xl"] = { id = 873614024, displayNameWithSize = "Exotic Standard Frame xl" },
         ["Exotic Standard Frame xs"] = { id = 873614065, displayNameWithSize = "Exotic Standard Frame xs" },
         ["Rare Reinforced Frame l"] = { id = 994058003, displayNameWithSize = "Rare Reinforced Frame l" },
         ["Rare Reinforced Frame m"] = { id = 994058004, displayNameWithSize = "Rare Reinforced Frame m" },
         ["Rare Reinforced Frame s"] = { id = 994057994, displayNameWithSize = "Rare Reinforced Frame s" },
         ["Rare Reinforced Frame xl"] = { id = 1179605671, displayNameWithSize = "Rare Reinforced Frame xl" },
         ["Rare Reinforced Frame xs"] = { id = 1179605664, displayNameWithSize = "Rare Reinforced Frame xs" },
         ["Rare Standard Frame l"] = { id = 1981362670, displayNameWithSize = "Rare Standard Frame l" },
         ["Rare Standard Frame m"] = { id = 1981362671, displayNameWithSize = "Rare Standard Frame m" },
         ["Rare Standard Frame s"] = { id = 1981362581, displayNameWithSize = "Rare Standard Frame s" },
         ["Rare Standard Frame xl"] = { id = 873667227, displayNameWithSize = "Rare Standard Frame xl" },
         ["Rare Standard Frame xs"] = { id = 873667202, displayNameWithSize = "Rare Standard Frame xs" },
         ["Uncommon Reinforced Frame l"] = { id = 994058140, displayNameWithSize = "Uncommon Reinforced Frame l" },
         ["Uncommon Reinforced Frame m"] = { id = 994058141, displayNameWithSize = "Uncommon Reinforced Frame m" },
         ["Uncommon Reinforced Frame s"] = { id = 994058119, displayNameWithSize = "Uncommon Reinforced Frame s" },
         ["Uncommon Reinforced Frame xl"] = { id = 1179614597, displayNameWithSize = "Uncommon Reinforced Frame xl" },
         ["Uncommon Reinforced Frame xs"] = { id = 1179614604, displayNameWithSize = "Uncommon Reinforced Frame xs" },
         ["Uncommon Standard Frame l"] = { id = 1981362539, displayNameWithSize = "Uncommon Standard Frame l" },
         ["Uncommon Standard Frame m"] = { id = 1981362536, displayNameWithSize = "Uncommon Standard Frame m" },
         ["Uncommon Standard Frame s"] = { id = 1981362450, displayNameWithSize = "Uncommon Standard Frame s" },
         ["Uncommon Standard Frame xl"] = { id = 873676093, displayNameWithSize = "Uncommon Standard Frame xl" },
         ["Uncommon Standard Frame xs"] = { id = 873676070, displayNameWithSize = "Uncommon Standard Frame xs" },

      }
    }

    --- GetId
    -- Maps display name to id. Returns -1 if display name was not in the table.
    ---@param displayName string the display name to retrieve id for
    -- @return an id that represents the element
    function self.GetId(displayName)
      if(self.displayNameToId[displayName]) then
        return self.displayNameToId[displayName].id
      end
      return -1
    end

    --- GetDisplayName
    -- Maps id to display name. Will call system.getItem() if necessary.
    ---@param id number the id to retrieve display name for
    -- @return a string that is the Display Name of the item
    function self.GetDisplayName(id)
      if(self.idToDisplayName[id]) then
        return self.idToDisplayName[id].displayNameWithSize
      end

      local item = system.getItem(id)
      if(item and item.displayNameWithSize) then
        system.print("PureResources::GetDisplayName(" .. id .. ") had to bail back to system call for " .. item.displayNameWithSize)
        return item.displayNameWithSize
      end

      system.print("PureResource::GetDisplayName(" .. id .. ") failed to get name")
      return ""
    end
     
    return self
  end
end


