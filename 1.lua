-- Safe UI-only payload.
-- Displays a small NeGmMod credit label. No ESP, wallhack, hooks,
-- anti-cheat bypass, or remote code execution.

local CreditTextWidget = nil

local function CreateCreditText()
  if CreditTextWidget and slua and slua.isValid and slua.isValid(CreditTextWidget) then
    return
  end

  pcall(function()
    local txt = CGame:NewObjectFromPath("/Script/UMG.TextBlock")
    if not txt or not slua.isValid(txt) then
      return
    end

    local hud = require("game_frontend_hud")
    if hud and hud.AddToContainer and UIContainers and UIContainers.Top then
      hud.AddToContainer(UIContainers.Top, txt, 9999)
    end

    txt:SetText("NeGmMod [ @NeGm_VIP6 ]")
    txt:SetColorAndOpacity(FSlateColor(FLinearColor(0, 1, 0, 1)))

    if txt.Font then
      local font = txt.Font
      font.Size = 12
      font.TypefaceFontName = "Bold"
      txt.Font = font
    end

    local WidgetLayoutLibrary = import("WidgetLayoutLibrary")
    if WidgetLayoutLibrary then
      local slot = WidgetLayoutLibrary.SlotAsCanvasSlot(txt)
      if slot then
        slot:SetAnchors(FAnchors(0, 1, 0, 1))
        slot:SetAlignment(FVector2D(0, 1))
        slot:SetPosition(FVector2D(25, -45))
        slot:SetSize(FVector2D(220, 30))
      end
    end

    if UEnums and UEnums.ESlateVisibility then
      txt:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
    end

    CreditTextWidget = txt
  end)
end

pcall(CreateCreditText)
