--- Mapping from industry state number to text description
-- @module IndustryState

if not IndustryState then

  --- The table mapping status number to text description
  -- @field IndustryState

  IndustryState = {
   [1] = "Stopped",
   [2] = "Running",
   [3] = "Missing Ingredient",
   [4] = "Ouptut Full",
   [5] = "No Output Container",
   [6] = "Pending",
   [7] = "Missing Schematic" 
  }
end


