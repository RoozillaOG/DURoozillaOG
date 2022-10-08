require "./ColorRGBA.lua"

if not UiCell then
  UiCell = {}
  UiCell.__index = UiCell

  UiCellStatusNormal = "Normal"
  UiCellStatusWarning = "Warning"
  UiCellStatusAlert = "Alert"
  UiCellStatusGood = "Good"

  --@param status string one of Normal, Warning, Alert
  function UiCell(font, data, status)
    self = {
      data = data,
      font = font,
      fontColor = ColorRGBAWhite,
      fillColor = ColorRGBABlack,
      status = status or UiCellStatusNormal
    }
  
    if(status == UiCellStatusGood) then
      self.fillColor = ColorRGBALightGreen      
    elseif(status == UiCellStatusWarning) then
      self.fillColor = ColorRGBALightYellow
    elseif(status == UiCellStatusAlert) then
      self.fillColor = ColorRGBALightRed
    end
    return self
  end

  function Draw(layer, fontSize, sx, sy, width, height)
    setNextFillColor(layer, self.fillColor.r, self.fillColor.g, self.fillColor.b, self.fillColor.a)
    addBox(layer, sx, sy, width, height)

    setNextTextAlign(layer, AlignH_Left, AlignV_Top)
    setNextStrokeColor(layer, self.fontColor.r, self.fontColor.g, self.fontColor.b, self.fontColor.a)
    addText(layer, self.font, data, sx, sy)
  end

end