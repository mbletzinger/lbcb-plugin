function addMessage(me,msg)
if isempty(me.msgHandle)
    me.log.info(dbstack,sprintf('Msg=%s',msg));
    return;
end

msgs = get(me.msgHandle,'String');
if ischar(msgs)
    nmsgs = {msg};
else
    nmsgs = [ msgs; {msg}];
end
set(me.msgHandle,'String',nmsgs);
end