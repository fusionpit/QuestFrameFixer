local _G = _G
local tinsert = tinsert
local GetFileIDFromPath = GetFileIDFromPath
local MAX_NUM_QUESTS = MAX_NUM_QUESTS

local ICONS = {
    activeQuest = GetFileIDFromPath("Interface\\GossipFrame\\ActiveQuestIcon"),
    availableQuest = GetFileIDFromPath("Interface\\GossipFrame\\AvailableQuestIcon")
}
if ClassicExpansionAtLeast(LE_EXPANSION_BURNING_CRUSADE) then
    ICONS.dailyQuest = GetFileIDFromPath("Interface\\GossipFrame\\DailyQuestIcon")
    ICONS.repeatableQuest = GetFileIDFromPath("Interface\\GossipFrame\\DailyActiveQuestIcon")
    ICONS.legendaryQuest = GetFileIDFromPath("Interface\\GossipFrame\\AvailableLegendaryQuestIcon")
end

local titleLines = {}
local questIconTextures = {}
for i = 1, MAX_NUM_QUESTS do
    local titleLine = _G["QuestTitleButton" .. i]
    tinsert(titleLines, titleLine)
    tinsert(questIconTextures, _G[titleLine:GetName() .. "QuestIcon"])
end
-- In Classic Era, the QuestFrame uses little yellow dots for both active and available quests
local function setClassicTexture(titleLine, iconTexture)
    if titleLine.isActive == 1 then
        iconTexture:SetTexture(ICONS.activeQuest)
    else
        iconTexture:SetTexture(ICONS.availableQuest)
    end
end
-- In TBC Classic (the second iteration), the QuestFrame incorrectly marks all available quests as a daily quest (except for legendary)
local function setTbcTexture(titleLine, iconTexture)
    if titleLine.isActive == 1 then return end
    local _, frequency, isRepeatable, isLegendary = GetAvailableQuestInfo(titleLine:GetID())
    if isLegendary then
        iconTexture:SetTexture(ICONS.legendaryQuest)
    elseif frequency > 1 then
        iconTexture:SetTexture(ICONS.dailyQuest)
    elseif isRepeatable then
        iconTexture:SetTexture(ICONS.repeatableQuest)
    else
        iconTexture:SetTexture(ICONS.availableQuest)
    end
end
local setTexture = ClassicExpansionAtLeast(LE_EXPANSION_BURNING_CRUSADE) and setTbcTexture or setClassicTexture
QuestFrameGreetingPanel:HookScript(
    "OnShow",
    function()
        for i, titleLine in ipairs(titleLines) do
            if titleLine:IsVisible() then
                local iconTexture = questIconTextures[i]
                setTexture(titleLine, iconTexture)
            end
        end
    end
)
