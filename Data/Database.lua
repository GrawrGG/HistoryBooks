local ArenaHistory, BGHistory, DungeonHistory, RaidHistory
HBDatabase = {}

function HBDatabase:Init()
    if (HBDBFile == nil) then
        HBDBFile = {
            arena = {},
            bg = {},
            dungeon = {},
            raid = {}
        }
    end
    local dbFile = HBDBFile
    ArenaHistory = dbFile.arena
    BGHistory = dbFile.bg
    DungeonHistory = dbFile.dungeon
    RaidHistory = dbFile.raid
end

function HBDatabase:SaveArena(arena)
    tinsert(ArenaHistory, arena)
end

function HBDatabase:SaveBG(bg)
    tinsert(BGHistory, bg)
end

function HBDatabase:SaveDungeon(dungeon)
    tinsert(DungeonHistory, dungeon)
end

function HBDatabase:SaveRaid(raid)
    tinsert(RaidHistory, raid)
end

-- HistoryBooksDatabase