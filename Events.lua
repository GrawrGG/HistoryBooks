local logger = HBLogger
local eventHandlers = {}

HBEvents = CreateFrame("FRAME", "HistoryBooks")

-- Because we can have multiple handlers for the same event, we provide a unique ID for each handler.
function HBEvents:RegisterEventHandler(event, handler, id)
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
  HBEvents:RegisterEvent(event)
end

function HBEvents:UnregisterEventHandler(event, id)
  logger.log("Unregistering event handler for " .. event)
  local handlers = eventHandlers[event]
  if (handlers) then
    handlers[id] = nil
    if next(handlers) == nil then
      -- No event handlers left, let's stop listening
      HBEvents:UnregisterEvent(event)
    end
  end
end

function HBEvents:HandleEvent(event, ...)
  logger.log("Handling event " .. event)
  local handlers = eventHandlers[event]
  if (handlers == nil) then
    logger.log("No handlers for " .. event)
    return
  end
  for _, handler in pairs(handlers) do
    handler(...)
  end
end

HBEvents:SetScript("OnEvent", HBEvents.HandleEvent)
