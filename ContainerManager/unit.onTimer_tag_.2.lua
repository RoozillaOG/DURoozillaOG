
require "../Utils/DUDebug.lua"

for k, v in pairs(containerMonitors) do
  DebugPrint(k .. " Updating container data")
  v.Update()
  --DebugPrint(v.GetDataBankKey() .. ": " .. json.encode(v.GetContent()))
end


