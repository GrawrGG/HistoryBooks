local function logString(stmt)
    print(stmt)
end

-- https://stackoverflow.com/a/41943392
local function serializeTable(tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2 
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
        toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
        toprint = toprint  .. k ..  "= "   
        end
        if (type(v) == "number") then
        toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
        toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
        toprint = toprint .. serializeTable(v, indent + 2) .. ",\r\n"
        else
        toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent-2) .. "}"
    return toprint
end

local function logTable(tbl)
    local stringifiedTable = serializeTable(tbl, 0)
    logString(stringifiedTable)
end

local function logger(obj)
    if (not HBConfiguration.DebuggingEnabled) then return end
    if (type(obj) == "table") then
        logTable(obj)
    else
        logString(obj)
    end
end

HBLogger = { 
    log = logger,
}