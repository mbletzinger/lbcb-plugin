function addMessage(me,msg)

msgs = get(me.msgHandle,'String');
if ischar(msgs)
    nmsgs = {msg};
else
    nmsgs = [ msgs; {msg}];
end
set(me.msgHandle,'String',nmsgs);
end