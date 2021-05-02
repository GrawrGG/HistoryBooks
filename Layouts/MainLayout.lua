HBMainLayout = {}

function HBMainLayout:Setup()
    HBDungeonLayout:Setup(HBFrame.Content)
end

function HBMainLayout:Show()
    HBFrame:Show()
end

function HBMainLayout:Hide()
    HBFrame:Hide()
end

function HBMainLayout:ToggleVisible()
    if (HBFrame:IsVisible()) then
        self:Hide()
    else 
        self:Show()
    end
end