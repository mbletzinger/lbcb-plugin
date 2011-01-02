% what now?
%clear java
%clear classes
%clc

% Set up Java libraries
javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'JavaLibrary'));

log = Logger;  % For debugging  messages

% Set up configuration
cfg = Configuration;
cfg.load();
ed1 = ElasticDeformationCalculations(cfg,0);
ed2 = ElasticDeformationCalculations(cfg,1);
NextTarget.setED(ed1,0);
NextTarget.setED(ed2,1);
NextTarget.setST(StepTolerances);
NextTarget.setDD(DerivedDof);

% Load input files
input1 = uigetfile('*.txt', 'LBCB 1 Input');
input2 = uigetfile('*.txt', 'LBCB 2 Input');
inpF = InputFile;
inpF.load(input1,input2);

% Run Simulation
nxtT = NextTarget(inpF);
notCompleted = 1;

while notCompleted
    nxtT.start();
    done = nxtT.isDone();
    while done == 0  % This loop is unecessary now but will be needed for hybrid testing
        done = nxtT.isDone();
    end
    step = nxtT.nextStep;
    if isempty(step)
        %Simulation is over
        notCompleted = 0;
        continue;
    end
    log.info(dbstack(),sprintf('Executing step %d:%d',step.simstep.step,step.simstep.subStep));
    % Add some fake LBCB readings
    for l = 1: length(step.lbcb)
        cp = step.lbcb{1};
        cp.response.lbcb.disp = cp.command.disp;
        cp.response.lbcb.force = cp.command.force;
        cp.externalSensors = zeros(3,1);
    end
    nxtT.curStep = step;
end