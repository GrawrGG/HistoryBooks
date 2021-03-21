local arena, bg, dungeon, raid

local function InitDb()
    HBDatabase:Init(arena, bg, dungeon, raid)
end

local function RegisterEvents()
    arena:RegisterEvents()
    bg:RegisterEvents()
    dungeon:RegisterEvents()
    raid:RegisterEvents()
end

local function RegisterSlashCmds()
    SlashCommands:Register()
end

local function Init()
    arena, bg, dungeon, raid = HBArena, HBBattleground, HBDungeon, HBRaid
    InitDb()
    RegisterEvents()
    RegisterSlashCmds()
end

Init()