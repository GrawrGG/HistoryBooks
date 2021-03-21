local logger = HBLogger
HBBattleground = {
    CurrentGame = nil,
    History = nil,
}

function HBBattleground:RegisterEvents()
    logger.log("Registering for battleground events")
    -- HistoryBooksEvents:RegisterEventHandler("ZONE_CHANGED_NEW_AREA", OnZoneChanged, "Arena_OnZoneChanged")
    -- HistoryBooksEvents:RegisterEventHandler("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld, "Arena_OnPlayerEnteringWorld")
    -- HistoryBooksEvents:RegisterEventHandler("ARENA_PREP_OPPONENT_SPECIALIZATIONS", OnArenaOpponentSpecs, "Arena_OnArenaOpponentSpecs")    
end