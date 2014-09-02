function mdlTgts = MOST_TransformResponse(me,lbcbTgts)
numLbcbs = me.cdp.numLbcbs();
mdlTgts = { Target };
if numLbcbs > 1
    mdlTgts = { mdlTgts{1}, Target};
end

numLbcbs = me.cdp.numLbcbs();
scaling = false;
scale_factor = [1 1 1 1 1 1 1 1]';

for lbcb = 1:numLbcbs
    
    if scaling
        disp = scaleValues(scale_factor(1:4),lbcbTgts{lbcb}.disp,false);
        forces= scaleValues(scale_factor(5:8),lbcbTgts{lbcb}.force,false);
    else
        disp = lbcbTgts{lbcb}.disp;
        forces= lbcbTgts{lbcb}.force;
    end
    
    % Set Displacements
    mdlTgts{lbcb}.setDispDof(1:6,disp);
    % Set Forces
    mdlTgts{lbcb}.setForceDof(1:6,forces);
    me.log.debug(dbstack, sprintf('M2 and L1 %s and %s', mdlTgts{lbcb}.toString(),lbcbTgts{lbcb}.toString()));
end
end
