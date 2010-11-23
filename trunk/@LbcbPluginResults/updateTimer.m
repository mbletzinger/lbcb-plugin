function updateTimer(me)
currenttime=cputime;
me.stepTimes(3)=currenttime;
% if isempty(me.stepTimes{1})
%     me.log.error(dbstack,sprintf('Step Times %d:%d',stepTimes(1),stepTimes(3)));
%     return;
% end
timediff=me.stepTimes(3)-me.stepTimes(1);
hours=floor(timediff/3600);
mins=floor((timediff-hours*3600)/60);
secs=round(timediff-hours*3600-mins*60);
currentstep=currenttime-me.stepTimes(2);
if currentstep<10;
    tt2=['0',num2str(currentstep,'%-2.1f')];
else
    tt2=num2str(currentstep,'%-2.1f');
end
if hours<10 && mins<10 && secs<10;
    tt1=['0',num2str(hours),':0',num2str(mins),':0',num2str(secs),' - '];
elseif hours<10 && mins<10;
    tt1=['0',num2str(hours),':0',num2str(mins),':',num2str(secs),' - '];
elseif hours<10;
    tt1=['0',num2str(hours),':',num2str(mins),':',num2str(secs),' - '];
else
    tt1=[num2str(hours),':',num2str(mins),':',num2str(secs),' - '];
end
set(me.handles.Timer,'String',sprintf('%s',[tt1 tt2]));
if isempty(me.commandCurrentValueHandles1) == false
    me.updateGui();
end
me.stepTimes(2)=currenttime;
end