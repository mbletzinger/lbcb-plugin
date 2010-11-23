function mdlTgts = OneExampleTransformResponse(me,lbcbTgts) 
mdlTgts = { Target Target }; % create a couple of model control points

% Set Dx from LBCB 1
mdlTgts{1}.setDispDof(1,lbcbTgts{1}.disp(1));
% Set Ry from LBCB 1
mdlTgts{1}.setDispDof(5,lbcbTgts{1}.disp(5));
% Set Fz from LBCB 2
mdlTgts{2}.setForceDof(3,lbcbTgts{2}.force(3));


% me.cdp access the configuration data
% number of LBCBs
me.cdp.numLbcbs();

% number of model control points
me.cdp.numModelCps();

% cell array of model control point addresses
addr = me.cdp.getAddresses();

end