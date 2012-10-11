function wharfPierEdAdjustTarget(me,curLbcbCp)
me.log.debug(dbstack,'ed Adjustment here*******************');
correctionDeltas = zeros(6,1);
ls = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz'};
lb = 'L1';

for d = 1:6
    lbl = sprintf('%scorDelta%s',lb,ls{d});
    correctionDeltas(d) = me.getArch(lbl);
end
curLbcbCp.command.disp = curLbcbCp.command.disp - correctionDeltas;
curLbcbCp.correctionDeltas = correctionDeltas;
curLbcbCp.command.clearNonControlDofs();
end
