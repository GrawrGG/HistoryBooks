-- Constants
local NUM_TABS = 2 -- Dungeons, Arenas
local DEFAULT_TAB = 1 -- Dungeons

-- Locals
local logger = HBLogger

HBMainLayout = {}

local function SetTitle()
  HBFrame.TitleText:SetText("History Books")
end

local function SetupTabs()
  PanelTemplates_SetNumTabs(HBFrame, NUM_TABS)
  PanelTemplates_SetTab(HBFrame, DEFAULT_TAB)
end

local function HideAll()
  HBDungeonLayout:Hide()
  -- HBArenaLayout:Hide()
end

local function ShowArena()
  HideAll()
  -- HBArenaLayout:Show()
end

local function ShowDungeon()
  HideAll()
  HBDungeonLayout:Show()
end

function HBMainLayout:Setup()
  SetTitle()
  SetupTabs()
  HBDungeonLayout:Setup(HBFrame.Content)
end

function HBMainLayout:Show()
  HBFrame:Show()
  HBDungeonLayout:Show()
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

function HBMainLayout:OnDungeonTabClick()
  logger.log("Showing dungeons")
  ShowDungeon()
end

function HBMainLayout:OnArenaTabClick()
  logger.log("Showing arenas")
  ShowArena()
end
