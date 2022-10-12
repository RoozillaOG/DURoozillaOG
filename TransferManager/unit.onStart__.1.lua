
require "../Industry/TransferManager.lua"

transfer = TransferManager(
  sTransferUnit1,
  sInputContainer1
)

sInputContainer1.updateContent()
transfer.Update()

unit.setTimer("CheckTransfer", 5)
unit.setTimer("UpdateContainer", 35)


