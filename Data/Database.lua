local ArenaHistory, BGHistory, DungeonHistory, RaidHistory
local PlayerID
HBDatabase = {}

function HBDatabase:Init()
  if (HBDBFile == nil) then
    HBDBFile = {}
  end
  PlayerID = UnitGUID("player")
  if (HBDBFile[PlayerID] == nil) then
    HBDBFile[PlayerID] = {
      arena = {},
      bg = {},
      dungeon = {},
      raid = {}
    }
  end
  local playerDb = HBDBFile[PlayerID]
  local playerName, _ = UnitName("player")
  playerDb.playerName = playerName
  ArenaHistory = playerDb.arena
  BGHistory = playerDb.bg
  DungeonHistory = playerDb.dungeon
  RaidHistory = playerDb.raid
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

function HBDatabase:DungeonHistory()
  return DungeonHistory
end
