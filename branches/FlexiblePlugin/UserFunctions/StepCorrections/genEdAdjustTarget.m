function genEdAdjustTarget(me,curLbcbCp)
me.log.debug(dbstack,'ed Adjustment here*******************');
curLbcbCp.command.disp = curLbcbCp.command.disp - me.correctionDeltas;
curLbcbCp.correctionDeltas = me.correctionDeltas;
curLbcbCp.command.clearNonControlDofs();
end
