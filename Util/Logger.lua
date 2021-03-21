HBLogger = { log = function(stmt)
    if (HBConfiguration.DebuggingEnabled) then
        print(stmt)
    end
}