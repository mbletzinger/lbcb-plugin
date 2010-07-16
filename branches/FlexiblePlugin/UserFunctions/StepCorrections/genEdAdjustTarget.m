function genEdAdjustTarget(me,curLbcbCp)
me.log.debug(dbstack,'ed Adjustment here*******************');
correctionDeltas = zeros(6,1);
ls = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz'};
for d = 1:6
    lbl = sprintf('corDelta%s',ls{d});
    correctionDeltas(d) = me.getDat{lbl};
end
curLbcbCp.command.disp = curLbcbCp.command.disp - correctionDeltas;
curLbcbCp.correctionDeltas = correctionDeltas;
curLbcbCp.command.clearNonControlDofs();
end
