function prelimAdjust(me,curStep, nextStep)
lbcb = 2;
if me.isLbcb1
    lbcb = 1;
end
%if curStep.stepNum.step == 0
%    me.log.info(dbstack,'Skipping prelim ED adjust on first step');
%    return;
%end
target = nextStep.lbcbCps{lbcb}.command.disp;
prevOMcommand = curStep.lbcbCps{lbcb}.command.disp;
position = curStep.lbcbCps{lbcb}.response.ed.disp;
correction = prevOMcommand - position;
if me.existsCfg('EdCorrectionFactor')
    cf = me.getCfg('EdCorrectionFactor');
else
    cf = 1;
end

newOMcommand = target + correction * cf;
str = sprintf('Prev Position: %s\n',curStep.lbcbCps{lbcb}.response.toString());
str = sprintf('%sPrev Cmd: %s\n',str,curStep.lbcbCps{lbcb}.command.toString());
str = sprintf('%sNew Target: %s\n',str,nextStep.lbcbCps{lbcb}.command.toString());

nextStep.lbcbCps{lbcb}.command.disp = newOMcommand;

str = sprintf('%sCorrectionFactor: %f\n',str,cf);
str = sprintf('%sNew Cmd: %s',str,nextStep.lbcbCps{lbcb}.command.toString());
me.log.debug(dbstack,str);
%me.archiveCorrections('prelimEd',correction);
end