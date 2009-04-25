function TestProposeExecuteMsgs()
clear classes
clc
targets = {LbcbTarget(), LbcbTarget};

targets{1}.setDispDof(0.003,1);
targets{2}.setDispDof(0.003,4);
targets{1}.setForceDof(35,2);
targets{2}.setForceDof(2000,6);

