function lbcbTgts = OneExampleTransformCommand(me,mdlTgts) 
lbcbTgts = { Target Target }; % create one Target for each LBCB

% Set Dx on LBCB 1
lbcbTgts{1}.setDispDof(1,mdlTgts{1}.disp(1));
% Set Ry on LBCB 1
lbcbTgts{1}.setDispDof(5,mdlTgts{1}.disp(5));
% Set Fz on LBCB 2
lbcbTgts{2}.setForceDof(3,mdlTgts{2}.force(3));


% me.cdp access the configuration data
% number of LBCBs
me.cdp.numLbcbs();

% number of model control points
me.cdp.numModelCps();

% cell array of model control point addresses
addr = me.cdp.getAddresses();

end