function test_suite = testStepNumber
initTestSuite;

function test_next

% ________________________________________________________
step = 0;
subStep = 0;
cStep = 0;
id = 0;
        
t = StepNumber(step, subStep, cStep);
% ________________________________________________________


% ________________________________________________________
% stepType = 0;

stepType = 0;

simstate = next(t,stepType);

stp = 1;
sStp = 0;
cStp = 0;

assertEqual(stp,simstate.step)
assertEqual(sStp,simstate.subStep)
assertEqual(cStp,simstate.correctionStep)
% ________________________________________________________


% ________________________________________________________
% stepType = 1;
stepType = stepType + 1;

simstate = next(t,stepType);

stp = 0;
sStp = 1;
cStp = 0;

assertEqual(stp,simstate.step)
assertEqual(sStp,simstate.subStep)
assertEqual(cStp,simstate.correctionStep)
% ________________________________________________________



% ________________________________________________________
% stepType = 2;
stepType = stepType + 1;

simstate = next(t,stepType);

stp = 0;
sStp = 0;
cStp = 1;

assertEqual(stp,simstate.step)
assertEqual(sStp,simstate.subStep)
assertEqual(cStp,simstate.correctionStep)
% ________________________________________________________



% ________________________________________________________
% stepType = 3;
stepType = stepType + 1;

simstate = next(t,stepType);

stp = 0;
sStp = 0;
cStp = 100;

assertEqual(stp,simstate.step)
assertEqual(sStp,simstate.subStep)
assertEqual(cStp,simstate.correctionStep)
% ________________________________________________________



% ________________________________________________________
% stepType = 4;
stepType = stepType + 1;

simstate = next(t,stepType);

stp = 0;
sStp = 0;
cStp = 100^2;

assertEqual(stp,simstate.step)
assertEqual(sStp,simstate.subStep)
assertEqual(cStp,simstate.correctionStep)
% ________________________________________________________



% ________________________________________________________
% stepType = 5;
stepType = stepType + 1;

simstate = next(t,stepType);

stp = 0;
sStp = 0;
cStp = 100^3;

assertEqual(stp,simstate.step)
assertEqual(sStp,simstate.subStep)
assertEqual(cStp,simstate.correctionStep)
% ________________________________________________________




function test_toString

step = 2;
subStep = 3;
cStep = 4;
id = 5;
        
t = StepNumber(step, subStep, cStep);

t_str = sprintf('2\t3\t4');
str = toString(t);

assertEqual(t_str,str)