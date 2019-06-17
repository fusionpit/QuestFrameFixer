local oldOnShow = QuestFrameGreetingPanel_OnShow;
QuestFrameGreetingPanel_OnShow = function()
    oldOnShow();
    
    for i = 1, MAX_NUM_QUESTS do
        local titleLine = getglobal("QuestTitleButton"..i);
        if (titleLine:IsVisible()) then
            local bulletPointTexture = titleLine:GetRegions();
            if (titleLine.isActive == 1) then
                bulletPointTexture:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon");
            else
                bulletPointTexture:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon");
            end
        end
    end
end
