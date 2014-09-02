function lbcbTgts = noTransformCommand(me,mdlTgts) %#ok<INUSD>
if me.cdp.numLbcbs() > 1
lbcbTgts = { me.lbcbCps{1}.command, me.lbcbCps{2}.command };
else
    lbcbTgts = { me.lbcbCps{1}.command };
end
end