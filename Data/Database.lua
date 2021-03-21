HBDatabase = {
    ArenaHistory = nil,
    BGHistory = nil,
    DungeonHistory = nil,
    RaidHistory = nil
}

function HBDatabase:Init(arena, bg, dungeon, raid)
    arena.History = self.ArenaHistory
    bg.History = self.BGHistory
    dungeon.History = self.DungeonHistory
    raid.History = self.RaidHistory
end

-- HistoryBooksDatabase