local logger = HBLogger

HistoryBooksEvents = CreateFrame("FRAME", "HistoryBooks")
local eventHandlers = {}

-- Because we can have multiple handlers for the same event, we provide a unique ID for each handler.
function HistoryBooksEvents:RegisterEventHandler(event, handler, id)
    logger.log("Registering event handler for " .. event)
    local handlers = eventHandlers[event]
    if (handlers == nil) then
        handlers = {}
        eventHandlers[event] = handlers
    end
    if (handlers[id]) then 
        logger.log("Replacing existing event handler for " .. event .. " with ID " .. id)
    end
    handlers[id] = handler
    HistoryBooksEvents:RegisterEvent(event)
end

function HistoryBooksEvents:UnregisterEventHandler(event, id)
    logger.log("Unregistering event handler for " .. event)
    local handlers = eventHandlers[event]
    if (handlers) then
        handlers[id] = nil
        if next(handlers) == nil then
            -- No event handlers left, let's stop listening
            HistoryBooksEvents:UnregisterEvent(event)
        end
    end
end

function HistoryBooksEvents:HandleEvent(event, ...)
    logger.log("Handling event " .. event)
    local handlers = eventHandlers[event]
    if (handlers == nil) then
        logger.log("No handlers for " ..  event)
        return 
    end
    for _, handler in pairs(handlers) do
        handler(...)
    end
end

HistoryBooksEvents:SetScript("OnEvent", HistoryBooksEvents.HandleEvent)
