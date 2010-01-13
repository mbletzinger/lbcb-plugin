function lbcbTgts = One2OneTransformCommand(me,mdlTgts) 
if me.cdp.numLbcbs() > 1    
lbcbTgts = { mdlTgts, mdlTgts };
else
    lbcbTgts = { mdlTgts };
end
end