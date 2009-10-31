% Exports the target data as an LBCB reading
function reading = target2Reading(me)
reading = lbcbReading();
reading.lbcb.disp = me.disp;
reading.lbcb.force = me.force;
end
