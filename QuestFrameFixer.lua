local _G = _G
local GetFileIDFromPath = GetFileIDFromPath
local MAX_NUM_QUESTS = MAX_NUM_QUESTS

local ACTIVE_QUEST_ICON_FILEID = GetFileIDFromPath("Interface\\GossipFrame\\ActiveQuestIcon")
local AVAILABLE_QUEST_ICON_FILEID = GetFileIDFromPath("Interface\\GossipFrame\\AvailableQuestIcon")

QuestFrameGreetingPanel:HookScript(
    "OnShow",
    function()
        for i = 1, MAX_NUM_QUESTS do
            local titleLine = _G["QuestTitleButton" .. i]
            if (titleLine:IsVisible()) then
                local bulletPointTexture = _G[titleLine:GetName() .. "QuestIcon"]
                if (titleLine.isActive == 1) then
                    bulletPointTexture:SetTexture(ACTIVE_QUEST_ICON_FILEID)
                else
                    bulletPointTexture:SetTexture(AVAILABLE_QUEST_ICON_FILEID)
                end
            end
        end
    end
)
