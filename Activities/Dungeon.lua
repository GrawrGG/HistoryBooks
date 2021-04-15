local logger = HBLogger
HBDungeon = {
    CurrentInstance = nil,
    History = nil,
}

local function OnChallengeModeStart()
    logger.log("Challenge mode started!")
    local _, _, _, _, _, _, _, instanceId = GetInstanceInfo()
    local keyLevel, affixes = C_ChallengeMode.GetActiveKeystoneInfo()
    -- TODO How is mapId different to instance ID?
    local mapId = C_ChallengeMode.GetActiveChallengeMapID()
    local instanceName, _, keyTimeLimit = C_ChallengeMode.GetMapUIInfo(mapId)
  
    local currentInstance = {
        affixes = affixes,
        instanceId = instanceId,
        instanceName = instanceName,
        enterTime = time(), -- TODO Start time?
        keyLevel = keyLevel,
        keyTimeLimit = keyTimeLimit,
        mapId = mapId,
        isComplete = false,
    }
    HBDungeon.CurrentInstance = currentInstance
    logger.log("Started dungeon:")
    logger.log(currentInstance)
end

local function OnChallengeModeComplete()
    logger.log("Challenge mode complete.")
    local currentInstance = HBDungeon.CurrentInstance
    if (currentInstance and not currentInstnace.isComplete) then
        currentInstance.finishTime = time()
        currentInstance.didFinish = true -- Did complete dungeon
        local success = (currentInstance.finishTime - currentInstance.enterTime) > currentInstance.keyTimeLimit
        currentInstanced.success = success -- Did we beat the timer?
        logger.log("Saving completed dungeon:")
        logger.log(dungeon)
        HBDungeon.CurrentInstance = nil
        tinsert(HBDungeon.History, currentInstance)
    end
end

local function OnChallengeModeReset()
    logger.log("Challenge mode reset.")
    local currentInstance = HBDungeon.CurrentInstance
    if (currentInstance and not currentInstnace.isComplete) then
        currentInstance.finishTime = time()
        currentInstance.didFinish = false -- Did not complete dungeon
        currentInstance.success = false -- Did not beat timer
        logger.log("Saving incomplete dungeon:")
        logger.log(dungeon)
        HBDungeon.CurrentInstance = nil
        tinsert(HBDungeon.History, currentInstance)
    end
end

function HBDungeon:RegisterEvents()
    logger.log("Registering for dungeon events")
    HistoryBooksEvents:RegisterEventHandler("CHALLENGE_MODE_START", OnChallengeModeStart, "Dungeon_OnChallengeModeStart")
    HistoryBooksEvents:RegisterEventHandler("CHALLENGE_MODE_COMPLETED", OnChallengeModeComplete, "Dungeon_OnChallengeModeCompleted")
    HistoryBooksEvents:RegisterEventHandler("CHALLENGE_MODE_RESET", OnChallengeModeReset, "Dungeon_OnChallengeModeReset")
end