


if not PureResources then
  PureResources = {}
  PureResources.__index = PureResources

  function PureResources()
    local self = {
      idToData = {
        ["2240749601"] = { id = 2240749601, displayNameWithSize = "Pure Aluminium" },
        ["2112763718"] = { id = 2112763718, displayNameWithSize = "Pure Calcium" },
        ["159858782"] = { id = 159858782, displayNameWithSize = "Pure Carbon" },
        ["2147954574"] = { id = 2147954574, displayNameWithSize = "Pure Chromium" },
        ["2031444137"] = { id = 2031444137, displayNameWithSize = "Pure Cobalt" },
        ["1466453887"] = { id = 1466453887, displayNameWithSize = "Pure Copper" },
        ["3323724376"] = { id = 3323724376, displayNameWithSize = "Pure Fluorine" },
        ["3837955371"] = { id = 3837955371, displayNameWithSize = "Pure Gold" },
        ["1010524904"] = { id = 1010524904, displayNameWithSize = "Pure Hydrogen" },
        ["198782496"] = { id = 198782496, displayNameWithSize = "Pure Iron" },
        ["3810111622"] = { id = 3810111622, displayNameWithSize = "Pure Lithium" },
        ["2421303625"] = { id = 2421303625, displayNameWithSize = "Pure Manganese" },
        ["3012303017"] = { id = 3012303017, displayNameWithSize = "Pure Nickel" },
        ["1126600143"] = { id = 1126600143, displayNameWithSize = "Pure Niobium" },
        ["947806142"] = { id = 947806142, displayNameWithSize = "Pure Oxygen" },
        ["3211418846"] = { id = 3211418846, displayNameWithSize = "Pure Scandium" },
        ["2589986891"] = { id = 2589986891, displayNameWithSize = "Pure Silicon" },
        ["1807690770"] = { id = 1807690770, displayNameWithSize = "Pure Silver" },
        ["3603734543"] = { id = 3603734543, displayNameWithSize = "Pure Sodium" },
        ["3822811562"] = { id = 3822811562, displayNameWithSize = "Pure Sulfur" },
        ["752542080"] = { id = 752542080, displayNameWithSize = "Pure Titanium" },
        ["2007627267"] = { id = 2007627267, displayNameWithSize = "Pure Vanadium" }
      },
      displayNameToData = {
        ["Pure Aluminium"] = { id = 2240749601, displayNameWithSize = "Pure Aluminium" },
        ["Pure Calcium"] = { id = 2112763718, displayNameWithSize = "Pure Calcium" },
        ["Pure Carbon"] = { id = 159858782, displayNameWithSize = "Pure Carbon" },
        ["Pure Chromium"] = { id = 2147954574, displayNameWithSize = "Pure Chromium" },
        ["Pure Cobalt"] = { id = 2031444137, displayNameWithSize = "Pure Cobalt" },
        ["Pure Copper"] = { id = 1466453887, displayNameWithSize = "Pure Copper" },
        ["Pure Fluorine"] = { id = 3323724376, displayNameWithSize = "Pure Fluorine" },
        ["Pure Gold"] = { id = 3837955371, displayNameWithSize = "Pure Gold" },
        ["Pure Hydrogen"] = { id = 1010524904, displayNameWithSize = "Pure Hydrogen" },
        ["Pure Iron"] = { id = 198782496, displayNameWithSize = "Pure Iron" },
        ["Pure Lithium"] = { id = 3810111622, displayNameWithSize = "Pure Lithium" },
        ["Pure Manganese"] = { id = 2421303625, displayNameWithSize = "Pure Manganese" },
        ["Pure Nickel"] = { id = 3012303017, displayNameWithSize = "Pure Nickel" },
        ["Pure Niobium"] = { id = 1126600143, displayNameWithSize = "Pure Niobium" },
        ["Pure Oxygen"] = { id = 947806142, displayNameWithSize = "Pure Oxygen" },
        ["Pure Scandium"] = { id = 3211418846, displayNameWithSize = "Pure Scandium" },
        ["Pure Silicon"] = { id = 2589986891, displayNameWithSize = "Pure Silicon" },
        ["Pure Silver"] = { id = 1807690770, displayNameWithSize = "Pure Silver" },
        ["Pure Sodium"] = { id = 3603734543, displayNameWithSize = "Pure Sodium" },
        ["Pure Sulfur"] = { id = 3822811562, displayNameWithSize = "Pure Sulfur" },
        ["Pure Titanium"] = { id = 752542080, displayNameWithSize = "Pure Titanium" },
        ["Pure Vanadium"] = { id = 2007627267, displayNameWithSize = "Pure Vanadium" }
      }
    }

    function self.GetId(displayName)
      return self.displayNameToData[displayName].id
    end

    function self.GetDisplayName(id)
      return self.idToData[id].displayNameWithSize
    end

    return self
  end
end

