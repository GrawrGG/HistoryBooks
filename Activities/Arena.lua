local logger = HBLogger
HBArena = {
    CurrentMatch = nil,
    History = nil,
}
local arena = HBArena

-- TODO Can we make these private 'instance' methods? Seems like they need to be defined in order otherwise.
local function IsInArena()
    local isInstance, instanceType = IsInInstance()
    return isInstance and instanceType == "arena"
end

local function SaveCurrentMatch()
    local currentMatch = HBArena.CurrentMatch
    if (currentMatch) then
        currentMatch.winningSide = GetBattlefieldWinner()
        if (currentMatch.winningSide == currentMatch.playerSide) then
            currentMatch.playerWon = true
        end

        currentMatch.players = {}
        for i=1, GetNumBattlefieldScores() do
            tinsert(currentMatch.players, { GetBattlefieldScore(i) })
        end

        currentMatch.endTime = time()
        
        logger.log("Saving arena match:")
        logger.log(currentMatch)
        HBArena.CurrentMatch = nil
        HBArena.History.append(currentMatch)
    end
end

local function AbandonCurrentMatch()
    local currentMatch = HBArena.CurrentMatch
    if (currentMatch) then
        logger.log("Saving abandoned arena match:")
        logger.log(currentMatch)
        HBArena.CurrentMatch = nil
        HBArena.History.append(currentMatch)
    end
end


local function TrackNewMatch()
    if not IsInArena() then return end
    -- local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()
    local instanceID = select(8, GetInstanceInfo())
    local _, isRated = IsActiveBattlefieldArena()
    local currentMatch = { 
        enterTime = time(), -- TODO Start time?
        instanceID = instanceID,
        isBrawl = C_PvP.IsInBrawl,
        isOver = false,
        isRated = isRated,
        playerSide = GetBattlefieldArenaFaction(),
        season = GetCurrentArenaSeason(),
     }
     logger.log("Tracking new arena match: ")
     logger.log(currentMatch)
     HBArena.CurrentMatch = currentMatch
end

local function IsTrackingMatch()
    return HBArena.CurrentMatch ~= nil
end

local function OnZoneChanged()
    logger.log("Arena - On zone changed")
    if IsTrackingMatch() and not IsInArena() then
        logger.log("Arena - zone change - current match deserted")
        AbandonCurrentMatch()
    elseif IsInArena() then
        logger.log("Arena - zone change - tracking new match")
        TrackNewMatch()
    else
        logger.log("Arena - zone change - doing nothing")
    end
end

local function DisableLeaveArenaButton()
    _G.PVPMatchResults.buttonContainer.leaveButton:Disable()
end

local function EnableLeaveArenaButton()
    _G.PVPMatchResults.buttonContainer.leaveButton:Enable()
end

local function OnMatchCompleted()
    if (HBArena.CurrentMatch == nil or HBArena.CurrentMatch.isOver) then return end
    HBArena.CurrentMatch.isOver = true
    DisableLeaveArenaButton()
    C_Timer.After(1, SaveCurrentMatch)
    C_Timer.After(1, EnableLeaveArenaButton)
end

-- TODO Handle disconnects when in an arena
-- local function OnPlayerEnteringWorld(...)
--     logger.log("Arena - On player entered world.")
--     logger.log(...)
-- end

-- TODO Save opponent info
-- local function OnArenaOpponentSpecs(...)
--     logger.log("Arena - On opponent specs")
--     logger.log(...)
-- end

function HBArena:RegisterEvents()
    logger.log("Registering for arena events")
    HistoryBooksEvents:RegisterEventHandler("ZONE_CHANGED_NEW_AREA", OnZoneChanged, "Arena_OnZoneChanged")
    HistoryBooksEvents:RegisterEventHandler("PVP_MATCH_COMPLETE", OnMatchCompleted, "Arena_OnMatchCompleted")

    -- HistoryBooksEvents:RegisterEventHandler("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld, "Arena_OnPlayerEnteringWorld")
    -- HistoryBooksEvents:RegisterEventHandler("ARENA_PREP_OPPONENT_SPECIALIZATIONS", OnArenaOpponentSpecs, "Arena_OnArenaOpponentSpecs")    
end

--[[
Logic should be:
- register various events
- handle loading into an arena, start tracking a match
- for each event which changes state, update match state (eg enemy team loaded, enemy specializations loaded, etc)
- on match ended, unsubscribe from events and then store match based on its current state

For unsubscribing... do I need to change my event handler? Rather than remember which events I'm tracking. 
    Yeah that's probably best, instead of going event,id it should be id,event and then I can delete all
        registered handlers for the given id. Also need to figure out the function calls.
]]--
