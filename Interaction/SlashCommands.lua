local MAX_ACTIVITIES_TO_PRINT = 10
local TEXT_COLOR_SUCCESS = "cFF00FF00" -- Green
local TEXT_COLOR_FAILURE = "cFFFF0000" -- Red

local logger = HBLogger

SLASH_HISTORYBOOKS1 = "/historybooks"
SLASH_HISTORYBOOKS2 = "/hb"

HBSlashCommands = {}

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
  local dungeons = HBDatabase:DungeonHistory()
  if (dungeons and dungeons[1]) then
    local dungeonCount = #dungeons
    local oldestDungeon = math.max(1, dungeonCount - MAX_ACTIVITIES_TO_PRINT)
    for i = oldestDungeon, dungeonCount do
      local d = dungeons[i]
      if (d) then
        local duration = HBDurationToString(d.finishTime - d.enterTime)
        local color
        if (d.success) then
          color = TEXT_COLOR_SUCCESS
        else
          color = TEXT_COLOR_FAILURE
        end
        print(d.instanceName .. " (" .. d.keyLevel .. ") |" .. color .. duration)
      end
    end
  else
    print("No dungeons recorded.")
  end
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

function HBSlashCommands:Register()
  logger.log("Registering slash commands")
  if (SlashCmdList["HISTORYBOOKS"] == nil) then
    SlashCmdList["HISTORYBOOKS"] = HandleHBSlashCmd
  end
end
