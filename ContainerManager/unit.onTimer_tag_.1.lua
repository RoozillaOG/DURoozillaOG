
for k, v in pairs(transferManagers) do
  DebugPrint(k .. "Updating transfer data")
  v.Update()
end


