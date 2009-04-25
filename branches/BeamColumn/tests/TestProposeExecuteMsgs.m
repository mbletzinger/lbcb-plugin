clear java
clear classes
clc
root = pwd

javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary'));

targets = {LbcbTarget(), LbcbTarget};

targets{1}.setDispDof(1,0.003);
targets{2}.setDispDof(4,0.003);
targets{1}.setForceDof(2,35);
targets{2}.setForceDof(6,2000);

simState = SimulationState();
network = Network(simState);
network.lbcbHost ='rp3267.cee.uiuc.edu';
network.lbcbPort ='6342';
network.setup();
pe = ProposeExecute(network.factory,network.lbcbLink);
pe.setTargets(targets);
notDone = 1;
while(notDone)
    done = pe.execute();
    [errorsExist errorMsg] = network.checkForErrors()
    if done || errorsExist
        notDone = 0;
    end
    pause(2);
end