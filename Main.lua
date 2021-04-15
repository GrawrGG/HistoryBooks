local logger = HBLogger

local function InitDb()
    logger.log("HB: InitDb")
    HBDatabase:Init()
end

local function OnAddonLoaded(addonName)
    if (addonName == "HistoryBooks") then
        HistoryBooksEvents:UnregisterEventHandler("ADDON_LOADED", "HBMain_OnAddonLoaded")
        logger.log("HB: Addon loaded.")
        InitDb()
    end
end

local function RegisterEvents()
    logger.log("HB: RegisterEvents")
    HBArena:RegisterEvents()
    HBBattleground:RegisterEvents()
    HBDungeon:RegisterEvents()
    HBRaid:RegisterEvents()
    HistoryBooksEvents:RegisterEventHandler("ADDON_LOADED", OnAddonLoaded, "HBMain_OnAddonLoaded")
end

local function RegisterSlashCmds()
    logger.log("HB: RegisterSlashCmds")
    SlashCommands:Register()
end

local function Init()
    logger.log("Initialising HistoryBooks addon")
    RegisterEvents()
    RegisterSlashCmds()
    logger.log("Finished initialising HistoryBooks.")
end

Init()