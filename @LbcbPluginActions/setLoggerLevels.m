function setLoggerLevels(me)
lcfg = LogLevelsDao(me.hfact.cfg);
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
end
