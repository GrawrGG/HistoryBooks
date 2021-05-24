local logger = HBLogger
local locals = {}

local function PrintHelp()
  print("History Books slash commands:")
  print("/hb help (?) -- prints this help")
  print("/hb arena -- prints arena history")
  print("/hb battlegrounds (bg) -- prints battlegrounds history")
  print("/hb dungeon (mythic, mp) -- prints dungeon history")
  print("/hb raid -- prints raid history")
end

local function PrintArena()
  print("Arena support not implemented")
end

local function PrintBG()
  print("Battleground support not implemented")
end

local function PrintDungeon()
  print("Dungeon support not implemented")
end

local function PrintRaid()
  print("Raid support not implemented")
end

local function HandleHBSlashCmd(msg)
  if msg == "arena" then
    PrintArena()
  elseif msg == "bg" or msg == "battlegrounds" then
    PrintBG()
  elseif msg == "dungeon" or msg == "mythic" or msg == "mp" then
    PrintDungeon()
  elseif msg == "raid" then
    PrintRaid()
  elseif msg == "help" or msg == "?" then
    PrintHelp()
  elseif strlen(msg) == 0 then
    HBMainLayout:ToggleVisible()
  end
end

local function RegisterHBSlashCmds()
  logger.log("Registering slash commands")
  if (SlashCmdList["HISTORYBOOKS"] == nil) then
    SlashCmdList["HISTORYBOOKS"] = HandleHBSlashCmd
  end
end

local function InitHBSlashCmd(arena, bg, dungeon, raid)
  locals.arena = arena
  locals.bg = bg
  locals.dungeon = dungeon
  locals.raid = raid
end

HBSlashCommands = {}
HBSlashCommands.Init = InitHBSlashCmd
HBSlashCommands.Handle = HandleHBSlashCmd
HBSlashCommands.Register = RegisterHBSlashCmds

SLASH_HISTORYBOOKS1 = "/historybooks"
SLASH_HISTORYBOOKS2 = "/hb"
