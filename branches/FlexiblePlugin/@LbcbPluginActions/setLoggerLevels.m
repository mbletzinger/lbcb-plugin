function setLoggerLevels(me)
lcfg = LogLevelsDao(me.cfg);
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
end
