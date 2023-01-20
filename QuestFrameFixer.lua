local DAILY_AVAILABLE_QUEST_ICON_FILEID = GetFileIDFromPath("Interface\\GossipFrame\\DailyQuestIcon")
local REPEAT_QUEST_ICON_FILEID = GetFileIDFromPath("Interface\\GossipFrame\\DailyActiveQuestIcon")

local oldAvailableSetup = GossipAvailableQuestButtonMixin.Setup
function GossipAvailableQuestButtonMixin:Setup(...)
    oldAvailableSetup(self, ...)
    if self.GetElementData ~= nil then
        local info = self.GetElementData().info
        if info == nil then return end
        local freq = info.frequency
        local isRepeatable = info.repeatable
        if isRepeatable then
            self.Icon:SetTexture(REPEAT_QUEST_ICON_FILEID)
        elseif (freq == 1) then
            self.Icon:SetTexture(DAILY_AVAILABLE_QUEST_ICON_FILEID)
        end
    end
end
