
if not RefinedProducts then
  RefinedProducts = {}
  RefinedProducts.__index = RefinedProducts

  function RefinedProducts()
    local self = {
      idToDisplayName = {
        [1942154251] = { id = 1942154251, displayNameWithSize = "Advanced Glass product" },
         [2301749833] = { id = 2301749833, displayNameWithSize = "Ag-Li Reinforced Glass product" },
         [18262914] = { id = 18262914, displayNameWithSize = "Al-Fe Alloy product" },
         [2021406770] = { id = 2021406770, displayNameWithSize = "Al-Li Alloy product" },
         [2646210914] = { id = 2646210914, displayNameWithSize = "Biological matter product" },
         [2679709617] = { id = 2679709617, displayNameWithSize = "Brick product" },
         [1034957327] = { id = 1034957327, displayNameWithSize = "Calcium Reinforced Copper product" },
         [1622880428] = { id = 1622880428, displayNameWithSize = "Carbon Fiber product" },
         [645870905] = { id = 645870905, displayNameWithSize = "Concrete product" },
         [1673011820] = { id = 1673011820, displayNameWithSize = "Cu-Ag Alloy product" },
         [994232382] = { id = 994232382, displayNameWithSize = "Deprecated Titanium 21 product" },
         [1531847536] = { id = 1531847536, displayNameWithSize = "Deprecated polycarbonate plastic product" },
         [2023317260] = { id = 2023317260, displayNameWithSize = "Deprecated zircaloy product" },
         [231758472] = { id = 231758472, displayNameWithSize = "Duralumin product" },
         [918590356] = { id = 918590356, displayNameWithSize = "Fluoropolymer product" },
         [3308209457] = { id = 3308209457, displayNameWithSize = "Glass product" },
         [606249095] = { id = 606249095, displayNameWithSize = "Gold-Coated Glass product" },
         [3292291904] = { id = 3292291904, displayNameWithSize = "Grade 5 Titanium Alloy product" },
         [167908167] = { id = 167908167, displayNameWithSize = "Inconel product" },
         [2790683457] = { id = 2790683457, displayNameWithSize = "Lithium Cobaltate product" },
         [3790459776] = { id = 3790459776, displayNameWithSize = "Lithium niobate product" },
         [3987872305] = { id = 3987872305, displayNameWithSize = "Mangalloy product" },
         [4150961531] = { id = 4150961531, displayNameWithSize = "Manganese Reinforced Glass product" },
         [3518490274] = { id = 3518490274, displayNameWithSize = "Maraging Steel product" },
         [331532952] = { id = 331532952, displayNameWithSize = "Marble product" },
         [4103265826] = { id = 4103265826, displayNameWithSize = "Polycalcite plastic product" },
         [2014531313] = { id = 2014531313, displayNameWithSize = "Polycarbonate plastic product" },
         [2097691217] = { id = 2097691217, displayNameWithSize = "Polysulfide plastic product" },
         [2550840787] = { id = 2550840787, displayNameWithSize = "Red Gold Product" },
         [2929462635] = { id = 2929462635, displayNameWithSize = "Sc-Al Alloy Product" },
         [2565702107] = { id = 2565702107, displayNameWithSize = "Silumin Product" },
         [2984358477] = { id = 2984358477, displayNameWithSize = "Stainless Steel product" },
         [511774178] = { id = 511774178, displayNameWithSize = "Steel product" },
         [2348042377] = { id = 2348042377, displayNameWithSize = "Sulfur Acid product" },
         [1734893264] = { id = 1734893264, displayNameWithSize = "Ti-Nb Supraconductor product" },
         [2479827059] = { id = 2479827059, displayNameWithSize = "Tier 1 Product Honeycomb Schematic Copy" },
         [690638651] = { id = 690638651, displayNameWithSize = "Tier 1 Product Material Schematic Copy" },
         [632722426] = { id = 632722426, displayNameWithSize = "Tier 2 Product Honeycomb Schematic Copy" },
         [4073976374] = { id = 4073976374, displayNameWithSize = "Tier 2 Product Material Schematic Copy" },
         [2343247971] = { id = 2343247971, displayNameWithSize = "Tier 3 Product Honeycomb Schematic Copy" },
         [3707339625] = { id = 3707339625, displayNameWithSize = "Tier 3 Product Material Schematic Copy" },
         [3743434922] = { id = 3743434922, displayNameWithSize = "Tier 4 Product Honeycomb Schematic Copy" },
         [2485530515] = { id = 2485530515, displayNameWithSize = "Tier 4 Product Material Schematic Copy" },
         [1885016266] = { id = 1885016266, displayNameWithSize = "Tier 5 Product Honeycomb Schematic Copy" },
         [2752973532] = { id = 2752973532, displayNameWithSize = "Tier 5 Product Material Schematic Copy" },
         [255776324] = { id = 255776324, displayNameWithSize = "Vanamer product" },
         [770773323] = { id = 770773323, displayNameWithSize = "Wood product" },

      },
      displayNameToId = {
        ["Advanced Glass product"] = { id = 1942154251, displayNameWithSize = "Advanced Glass product" },
         ["Ag-Li Reinforced Glass product"] = { id = 2301749833, displayNameWithSize = "Ag-Li Reinforced Glass product" },
         ["Al-Fe Alloy product"] = { id = 18262914, displayNameWithSize = "Al-Fe Alloy product" },
         ["Al-Li Alloy product"] = { id = 2021406770, displayNameWithSize = "Al-Li Alloy product" },
         ["Biological matter product"] = { id = 2646210914, displayNameWithSize = "Biological matter product" },
         ["Brick product"] = { id = 2679709617, displayNameWithSize = "Brick product" },
         ["Calcium Reinforced Copper product"] = { id = 1034957327, displayNameWithSize = "Calcium Reinforced Copper product" },
         ["Carbon Fiber product"] = { id = 1622880428, displayNameWithSize = "Carbon Fiber product" },
         ["Concrete product"] = { id = 645870905, displayNameWithSize = "Concrete product" },
         ["Cu-Ag Alloy product"] = { id = 1673011820, displayNameWithSize = "Cu-Ag Alloy product" },
         ["Deprecated Titanium 21 product"] = { id = 994232382, displayNameWithSize = "Deprecated Titanium 21 product" },
         ["Deprecated polycarbonate plastic product"] = { id = 1531847536, displayNameWithSize = "Deprecated polycarbonate plastic product" },
         ["Deprecated zircaloy product"] = { id = 2023317260, displayNameWithSize = "Deprecated zircaloy product" },
         ["Duralumin product"] = { id = 231758472, displayNameWithSize = "Duralumin product" },
         ["Fluoropolymer product"] = { id = 918590356, displayNameWithSize = "Fluoropolymer product" },
         ["Glass product"] = { id = 3308209457, displayNameWithSize = "Glass product" },
         ["Gold-Coated Glass product"] = { id = 606249095, displayNameWithSize = "Gold-Coated Glass product" },
         ["Grade 5 Titanium Alloy product"] = { id = 3292291904, displayNameWithSize = "Grade 5 Titanium Alloy product" },
         ["Inconel product"] = { id = 167908167, displayNameWithSize = "Inconel product" },
         ["Lithium Cobaltate product"] = { id = 2790683457, displayNameWithSize = "Lithium Cobaltate product" },
         ["Lithium niobate product"] = { id = 3790459776, displayNameWithSize = "Lithium niobate product" },
         ["Mangalloy product"] = { id = 3987872305, displayNameWithSize = "Mangalloy product" },
         ["Manganese Reinforced Glass product"] = { id = 4150961531, displayNameWithSize = "Manganese Reinforced Glass product" },
         ["Maraging Steel product"] = { id = 3518490274, displayNameWithSize = "Maraging Steel product" },
         ["Marble product"] = { id = 331532952, displayNameWithSize = "Marble product" },
         ["Polycalcite plastic product"] = { id = 4103265826, displayNameWithSize = "Polycalcite plastic product" },
         ["Polycarbonate plastic product"] = { id = 2014531313, displayNameWithSize = "Polycarbonate plastic product" },
         ["Polysulfide plastic product"] = { id = 2097691217, displayNameWithSize = "Polysulfide plastic product" },
         ["Red Gold Product"] = { id = 2550840787, displayNameWithSize = "Red Gold Product" },
         ["Sc-Al Alloy Product"] = { id = 2929462635, displayNameWithSize = "Sc-Al Alloy Product" },
         ["Silumin Product"] = { id = 2565702107, displayNameWithSize = "Silumin Product" },
         ["Stainless Steel product"] = { id = 2984358477, displayNameWithSize = "Stainless Steel product" },
         ["Steel product"] = { id = 511774178, displayNameWithSize = "Steel product" },
         ["Sulfur Acid product"] = { id = 2348042377, displayNameWithSize = "Sulfur Acid product" },
         ["Ti-Nb Supraconductor product"] = { id = 1734893264, displayNameWithSize = "Ti-Nb Supraconductor product" },
         ["Tier 1 Product Honeycomb Schematic Copy"] = { id = 2479827059, displayNameWithSize = "Tier 1 Product Honeycomb Schematic Copy" },
         ["Tier 1 Product Material Schematic Copy"] = { id = 690638651, displayNameWithSize = "Tier 1 Product Material Schematic Copy" },
         ["Tier 2 Product Honeycomb Schematic Copy"] = { id = 632722426, displayNameWithSize = "Tier 2 Product Honeycomb Schematic Copy" },
         ["Tier 2 Product Material Schematic Copy"] = { id = 4073976374, displayNameWithSize = "Tier 2 Product Material Schematic Copy" },
         ["Tier 3 Product Honeycomb Schematic Copy"] = { id = 2343247971, displayNameWithSize = "Tier 3 Product Honeycomb Schematic Copy" },
         ["Tier 3 Product Material Schematic Copy"] = { id = 3707339625, displayNameWithSize = "Tier 3 Product Material Schematic Copy" },
         ["Tier 4 Product Honeycomb Schematic Copy"] = { id = 3743434922, displayNameWithSize = "Tier 4 Product Honeycomb Schematic Copy" },
         ["Tier 4 Product Material Schematic Copy"] = { id = 2485530515, displayNameWithSize = "Tier 4 Product Material Schematic Copy" },
         ["Tier 5 Product Honeycomb Schematic Copy"] = { id = 1885016266, displayNameWithSize = "Tier 5 Product Honeycomb Schematic Copy" },
         ["Tier 5 Product Material Schematic Copy"] = { id = 2752973532, displayNameWithSize = "Tier 5 Product Material Schematic Copy" },
         ["Vanamer product"] = { id = 255776324, displayNameWithSize = "Vanamer product" },
         ["Wood product"] = { id = 770773323, displayNameWithSize = "Wood product" },

      }
    }

    function self.GetId(displayName)
      if(self.displayNameToId[displayName]) then
        return self.displayNameToId[displayName].id
      end
      return -1
    end

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
  end
end

