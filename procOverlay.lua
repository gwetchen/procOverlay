local f = CreateFrame("Frame")
local _, playerGUID = UnitExists("player")

--print("procOverlay loaded")

local Left = CreateFrame("Frame")
Left:SetFrameStrata("HIGH")
Left:SetWidth(128)
Left:SetHeight(128)
Left:SetPoint("CENTER",-100,-50)
Left.texture = Left:CreateTexture(nil, "HIGH")
Left.texture:SetTexture("")
Left.texture:SetAllPoints()
Left:Hide()

local Right = CreateFrame("Frame")
Right:SetFrameStrata("HIGH")
Right:SetWidth(128)
Right:SetHeight(128)
Right:SetPoint("CENTER",100,-50)
Right.texture = Right:CreateTexture(nil, "HIGH")
Right.texture:SetTexture("")
Right.texture:SetAllPoints()
Right:Hide()

local Top = CreateFrame("Frame")
Top:SetFrameStrata("HIGH")
Top:SetWidth(192)
Top:SetHeight(96)
Top:SetPoint("CENTER",0,130)
Top.texture = Top:CreateTexture(nil, "HIGH")
Top.texture:SetTexture("")
Top.texture:SetAllPoints()
Top:Hide()

--[[local Barkskin = CreateFrame("Frame")
Barkskin:SetFrameStrata("HIGH")
Barkskin:SetWidth(32)
Barkskin:SetHeight(32)
Barkskin:SetPoint("CENTER",0,0)
Barkskin.texture = Barkskin:CreateTexture(nil, "HIGH")
Barkskin.texture:SetTexture("Interface\\Icons\\Spell_Nature_StoneClawTotem")
Barkskin.texture:SetAllPoints()
Barkskin.texture:SetTexCoord(.1,1,0,1)
Barkskin:Show()]]--

local function checkBuffByID(buffID)
    for i = 1,32 do
        local texture, stacks, id = UnitBuff("player", i)
        if id == buffID then
            return true
        end
    end
    return false
end

f:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") --"You gain X(1)."
f:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF") --"X fades from you."
f:RegisterEvent("PLAYER_AURAS_CHANGED") --Called when a buff or debuff is either applied to a unit or is removed from the player.
f:RegisterEvent("UNIT_CASTEVENT") --superwow

local DruidBuffs = {
    [16870] = true, --Clearcasting
    [16886] = true, --Natrures's Grace
}



f:SetScript("OnEvent", function()
    if event == "PLAYER_AURAS_CHANGED" then
        local Clearcasting = checkBuffByID(16870)
        local NatruresGrace = checkBuffByID(16886)
        if Clearcasting == true then --NG: 16886
            Left.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\OmenLeft")
            Left:Show()
            Right.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\OmenRight")
            Right:Show()
        end
        if Clearcasting == false then
            Right:Hide()
            Left:Hide()
        end
        if NatruresGrace == true then
            Top.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\NaturesGrace")
            Top:Show()
        end
        if NatruresGrace == false then
            Top:Hide()
        end
    end
    --[[if event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" then
        if string.find(arg1, "You gain Clearcasting") then
            Left.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\OmenLeft")
            Left:Show()
            Right.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\OmenRight")
            Right:Show()
        end
    end
    if event == "CHAT_MSG_SPELL_AURA_GONE_SELF" then
        if string.find(arg1, "Clearcasting fades from you") then
            Right:Hide()
            Left:Hide()
        end
    end
   if event == "UNIT_CASTEVENT" then
        if arg1 == playerGUID then
            if arg4 == 22812 then
                cd1.texture:SetTexture("Interface\Icons\spell_nature_stoneclawtotem")
                cd1:Show()
            end
        end
    end]]--
    --[[if event == "UNIT_CASTEVENT" then
        if arg4 == 16870 then
            f:Show()
        end
    end]]--
end)