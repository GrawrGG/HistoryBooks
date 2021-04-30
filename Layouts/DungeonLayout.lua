local ScrollingTable = LibStub("ScrollingTable")
local logger = HBLogger

local ROW_HEIGHT = 40
local ICON_PADDING = 4
local NUM_ROWS = 12

-- Column indexes
local COL_INDEX_ICON = 1
local COL_INDEX_NAME = 2
local COL_INDEX_TIME = 3

-- Column widths
local COL_WIDTH_ICON = ROW_HEIGHT
local COL_WIDTH_NAME = 150
local COL_WIDTH_TIME = 150

local DUNGEON_COLUMNS = {
    {
        ["name"] = "Icon",
        ["width"] = COL_WIDTH_ICON,
        ["DoCellUpdate"] = nil
    },
    {
        ["name"] = "Name",
        ["width"] = COL_WIDTH_NAME,
        ["DoCellUpdate"] = nil
    },
    {
        ["name"] = "Time",
        ["width"] = COL_WIDTH_TIME,
        ["DoCellUpdate"] = nil
    }
}

local function SetDungeonIcon(rowFrame, cellFrame, data, cols, row, realrow, column, fShow, table, ...)
    if (cellFrame.Background == nil) then
        local frameSize = ROW_HEIGHT - ICON_PADDING
        cellFrame:SetSize(frameSize, frameSize)
        cellFrame.Background = cellFrame:CreateTexture(nil, "BACKGROUND")
        cellFrame.Background:SetPoint("TOPLEFT", cellFrame, "TOPLEFT")
        cellFrame.Background:SetPoint("BOTTOMRIGHT", cellFrame, "BOTTOMRIGHT")
    end
    local dungeonID = data[realrow].cols[COL_INDEX_ICON].value
    local _, _, _, backgroundTexture = C_ChallengeMode.GetMapUIInfo(dungeonID)
    cellFrame.Background:SetTexture(backgroundTexture)
end

local function GetDungeonName(dungeonID)
    local dungeonName = C_ChallengeMode.GetMapUIInfo(dungeonID)
    return dungeonName
end

local function CreateRowData(dungeonID, duration, didTime)
    return {
        ["cols"] = {
            [COL_INDEX_ICON] = {
                ["value"] = dungeonID,
                ["DoCellUpdate"] = SetDungeonIcon
            },
            [COL_INDEX_NAME] = {
                ["value"] = GetDungeonName,
                ["args"] = {dungeonID}
            },
            [COL_INDEX_TIME] = {
                ["value"] = duration
            }
        }
    }
end

local DUNGEON_ROWS = {
    -- Fake data
    CreateRowData(375, "10:00", false),
    CreateRowData(376, "12:00", false),
    CreateRowData(377, "14:00", false),
    CreateRowData(378, "16:00", false),
    CreateRowData(379, "18:00", false),
    CreateRowData(380, "11:00", false),
    CreateRowData(381, "13:00", false),
    CreateRowData(382, "15:00", false),
    CreateRowData(375, "10:00", false),
    CreateRowData(376, "12:00", false),
    CreateRowData(377, "14:00", false),
    CreateRowData(378, "16:00", false),
    CreateRowData(379, "18:00", false),
    CreateRowData(380, "11:00", false),
    CreateRowData(381, "13:00", false),
    CreateRowData(382, "15:00", false),
    CreateRowData(375, "10:00", false),
    CreateRowData(376, "12:00", false),
    CreateRowData(377, "14:00", false),
    CreateRowData(378, "16:00", false),
    CreateRowData(379, "18:00", false),
    CreateRowData(380, "11:00", false),
    CreateRowData(381, "13:00", false),
    CreateRowData(382, "15:00", false)
}

HBDungeonLayout = {}
local DungeonTable

-- Setup the Dungeon view into the supplied [frame].
function HBDungeonLayout:Setup(frame)
    DungeonTable = ScrollingTable:CreateST(DUNGEON_COLUMNS, NUM_ROWS, ROW_HEIGHT, nil, frame)
    DungeonTable.head:SetHeight(25)
    DungeonTable.frame:ClearAllPoints()
    DungeonTable.frame:SetPoint("TOPLEFT", frame, "TOPLEFT")
    DungeonTable.frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    DungeonTable:SetData(DUNGEON_ROWS)
end
