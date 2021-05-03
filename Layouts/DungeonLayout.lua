-- Imports
local ScrollingTable = LibStub("ScrollingTable")

-- Constants
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

-- Locals
local logger = HBLogger
local dungeonTable
local rows = nil -- Lazy load our data

HBDungeonLayout = {}

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

local function GetDungeonTimeColor(didCompleteInTime)
    local red, green = 0.0, 0.0
    if didCompleteInTime then 
        green = 1.0
    else 
        red = 1.0
    end
    return { 
        ["r"] = red,
        ["g"] = green,
        ["b"] = 0.0,
        ["a"] = 1.0,
    }
end

local function GetDungeonTime(duration)
    -- TODO Format duration in hours:mins:seconds
    return duration
end

local function CreateRowData(dungeon)
    local mapId = dungeon.mapId
    local duration = dungeon.finishTime - dungeon.enterTime
    return {
        ["cols"] = {
            [COL_INDEX_ICON] = {
                ["value"] = mapId,
                ["DoCellUpdate"] = SetDungeonIcon
            },
            [COL_INDEX_NAME] = {
                ["value"] = GetDungeonName,
                ["args"] = {mapId}
            },
            [COL_INDEX_TIME] = {
                ["value"] = GetDungeonTime,
                ["args"] = { duration },
                ["color"] = GetDungeonTimeColor,
                ["colorargs"] = { dungeon.success }
            }
        },
        ["dungeon"] = dungeon
    }
end

-- Setup the Dungeon view into the supplied [frame].
function HBDungeonLayout:Setup(frame)
    dungeonTable = ScrollingTable:CreateST(DUNGEON_COLUMNS, NUM_ROWS, ROW_HEIGHT, nil, frame)
    dungeonTable.head:SetHeight(25)
    dungeonTable.frame:ClearAllPoints()
    dungeonTable.frame:SetPoint("TOPLEFT", frame, "TOPLEFT")
    dungeonTable.frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
end

-- Show the dungeon layout, loading data if needed
function HBDungeonLayout:Show()
    if (rows == nil) then
        rows = {}
        local history = HBDatabase:DungeonHistory()
        for _, dungeon in ipairs(history) do
            tinsert(rows, CreateRowData(dungeon))
        end
        dungeonTable:SetData(rows)
    end
    dungeonTable:Show()
end
