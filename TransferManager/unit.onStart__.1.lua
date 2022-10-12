
require "../Industry/TransferManager.lua"

transfer = TransferManager(
  sTransferUnit1,
  sInputContainer1
)

transfer.Update()

unit.setTimer("CheckTransfer", 60)


