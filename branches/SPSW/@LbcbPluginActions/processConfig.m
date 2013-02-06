function processConfig(me,action)
switch action
    case 'LOAD'
        me.hfact.cfg.load();
    case 'SAVE'
        me.hfact.cfg.save();
        return;
    case 'IMPORT'
        me.hfact.cfg.import();
    case 'EXPORT'
        me.hfact.cfg.export();
        return;
    otherwise
        me.log.error(dbstack, sprintf('%s not recognized',action));
end
me.hfact.gui.updateStepTolerances();
end