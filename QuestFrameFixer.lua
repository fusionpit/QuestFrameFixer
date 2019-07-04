local _G = _G
local GetFileIDFromPath = GetFileIDFromPath
local MAX_NUM_QUESTS = MAX_NUM_QUESTS

QuestFrameGreetingPanel:HookScript(
    "OnShow",
    function()
        for i = 1, MAX_NUM_QUESTS do
            local titleLine = _G["QuestTitleButton" .. i]
            if (titleLine:IsVisible()) then
                local bulletPointTexture = _G[titleLine:GetName() .. "QuestIcon"]
                if (titleLine.isActive == 1) then
                    bulletPointTexture:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon")
                else
                    bulletPointTexture:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon")
                end
            end
        end
    end
)
