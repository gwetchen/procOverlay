local f = CreateFrame("Frame")
local _, playerGUID = UnitExists("player")

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

local function checkBuffByID(buffID)
    for i = 1,32 do
        local texture, stacks, id = UnitBuff("player", i)
        if id == buffID then
            return true
        end
    end
    return false
end

local spellsThatConsumeCC = { --only max ranks for now
    [9850] = true, --claw
    [9830] = true,  --shred
    [31018] = true, --fb
    [9881] = true,  --maul
    [9904] = true,  --rake
    [9896] = true,  --rip
    [9867] = true,  --ravage
    [45736] = true, --savage bite
    [9827] = true,  --pounce
    [8983] = true,  --bash
    [45967] = true, --wrath
    [25298] = true, --SF
    [24977] = true, --IS
    [9835] = true,  --MF
    [17402] = true, --hurricane
    [20748] = true, --rebirth
    [9858] = true,  --regrowth
    [25299] = true, --rejuv
    [25297] = true, --healing touch
    [9863] = true,  --tranq
    [9908] = true,  --swipe 
    [9853] = true,  --entangling roots
}

--f:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") --"You gain X(1)."
--f:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF") --"X fades from you."
f:RegisterEvent("PLAYER_AURAS_CHANGED") --Called when a buff or debuff is either applied to a unit or is removed from the player.
f:RegisterEvent("UNIT_CASTEVENT") --superwow

local DruidBuffs = {
    [16870] = true, --Clearcasting
    [16886] = true, --Natrures's Grace
}

local clearCastTimer = 0

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
    if event == "UNIT_CASTEVENT" then
        if arg1 == playerGUID then
            if arg4 == 16870 then
                Left.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\OmenLeft")
                Left:Show()
                Right.texture:SetTexture("Interface\\AddOns\\procOverlay\\img\\OmenRight")
                Right:Show()
                clearCastTimer = GetTime()
            elseif spellsThatConsumeCC[arg4] then
                Right:Hide()
                Left:Hide()
            end           
        end
    end
    if GetTime() - clearCastTimer >= 15 then
        Right:Hide()
        Left:Hide()
    end
end)