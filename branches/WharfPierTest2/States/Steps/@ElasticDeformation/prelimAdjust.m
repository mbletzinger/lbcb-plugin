function prelimAdjust(me,curStep, nextStep)
lbcb = 2;
if me.isLbcb1
    lbcb = 1;
end
if curStep.stepNum.step == 0
    me.log.info(dbstack,'Skipping prelim ED adjust on first step');
    return;
end
target = nextStep.lbcbCps{lbcb}.command.disp;
prevOMcommand = curStep.lbcbCps{lbcb}.command.disp;
position = curStep.lbcbCps{lbcb}.response.ed.disp;
correction = target - prevOMcommand;
newOMcommand = position + correction;
me.log.debug(dbstack,sprintf('Orig Target: %s',nextStep.lbcbCps{lbcb}.command.toString()));
nextStep.lbcbCps{lbcb}.command.disp = newOMcommand;
me.log.debug(dbstack,sprintf('New Target: %s',nextStep.lbcbCps{lbcb}.command.toString()));
me.log.debug(dbstack,sprintf('Prev Cmd: %s',curStep.lbcbCps{lbcb}.command.toString()));
me.log.debug(dbstack,sprintf('Prev Position: %s',curStep.lbcbCps{lbcb}.response.toString()));
%me.archiveCorrections('prelimEd',correction);
end