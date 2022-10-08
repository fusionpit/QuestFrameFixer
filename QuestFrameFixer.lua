local DAILY_AVAILABLE_QUEST_ICON_FILEID = GetFileIDFromPath("Interface\\GossipFrame\\DailyQuestIcon")
local REPEAT_QUEST_ICON_FILEID = GetFileIDFromPath("Interface\\GossipFrame\\DailyActiveQuestIcon")

local function getLineAndIconMaps(maxLines, titleIdent, iconIdent)
    local lines = {}
    local icons = {}
    for i = 1, maxLines do
        local titleLine = _G[titleIdent .. i]
        tinsert(lines, titleLine)
        tinsert(icons, _G[titleLine:GetName() .. iconIdent])
    end
    return lines, icons
end

local function markDailies(lines, textures, ...)
    local lineIndex = 0
    for i=1, select("#", ...), 7 do
        lineIndex = lineIndex + 1
        local activeQuestLine = lines[lineIndex]
        if activeQuestLine:IsVisible() and activeQuestLine.type == 'Available' then
            local _, _, _, frequency, isRepeatable = select(i, ...)
            if isRepeatable then
                local texture = textures[lineIndex]
                texture:SetTexture(REPEAT_QUEST_ICON_FILEID)
            elseif (frequency == LE_QUEST_FREQUENCY_DAILY or frequency == LE_QUEST_FREQUENCY_WEEKLY) then
                local texture = textures[lineIndex]
                texture:SetTexture(DAILY_AVAILABLE_QUEST_ICON_FILEID)
            end
        end
    end
end

local gossipTitleLines, gossipIconTextures = getLineAndIconMaps(NUMGOSSIPBUTTONS, "GossipTitleButton", "GossipIcon")
hooksecurefunc("GossipFrameUpdate", function()
    markDailies(gossipTitleLines, gossipIconTextures, GetGossipAvailableQuests())
end)
