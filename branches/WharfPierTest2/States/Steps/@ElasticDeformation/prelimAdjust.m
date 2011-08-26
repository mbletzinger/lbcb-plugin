function prelimAdjust(me,curStep, nextStep)
lbcb = 2;
if me.isLbcb1
    lbcb = 1;
end
target = nextStep.lbcbCps{lbcb}.command.disp;
prevOMcommand = curStep.lbcbCps{lbcb}.command.disp;
position = curStep.lbcbCps{lbcb}.response.ed.disp;
correction = target - prevOMcommand;
newOMcommand = position + correction;
correction = position - prevOMcommand;
newOMcommand = target + correction;
nextStep.lbcbCps{lbcb}.command.disp = newOMcommand;

me.archiveCorrections('prelimEd',correction);
end