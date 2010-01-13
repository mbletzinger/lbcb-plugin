function mdlTgts = One2OneTransformResponse(me,lbcbTgts) 
if me.cdp.numLbcbs() > 1    
mdlTgts = { lbcbTgts, lbcbTgts };
else
    mdlTgts = { lbcbTgts };
end

end