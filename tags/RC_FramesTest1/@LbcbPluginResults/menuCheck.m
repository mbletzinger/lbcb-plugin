function  menuCheck(me,menuName,isOn)
if isempty(me.handles) || me.shuttingDown
    me.log.info(dbstack,sprintf('menuName=%s is %s',menuName,isOn));
    return;
end

switch menuName
    case 'TRIGGER'
        hndl = me.triggerHandles(1);
    case 'VAMP'
        hndl = me.triggerHandles(2);
    case 'ARCHIVE'
        hndl = me.triggerHandles(3);
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',menuName));
end
str = 'off';
if isOn
    str = 'on';
end
set(hndl, 'Checked',str);
end