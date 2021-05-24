local logger = HBLogger
HBRaid = {
  CurrentInstance = nil,
  History = nil
}

function HBRaid:RegisterEvents()
  logger.log("Registering for raid events")
  -- HBEvents:RegisterEventHandler("ZONE_CHANGED_NEW_AREA", OnZoneChanged, "Arena_OnZoneChanged")
  -- HBEvents:RegisterEventHandler("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld, "Arena_OnPlayerEnteringWorld")
  -- HBEvents:RegisterEventHandler("ARENA_PREP_OPPONENT_SPECIALIZATIONS", OnArenaOpponentSpecs, "Arena_OnArenaOpponentSpecs")
end
