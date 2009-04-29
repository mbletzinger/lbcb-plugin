clear java
clear classes
clc
root = pwd

javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary'));

responses = {Target(),Target(),Target()};

responses{1}.setDispDof(1,0.003);
responses{2}.setDispDof(4,0.003);
responses{1}.setForceDof(2,35);
responses{2}.setForceDof(6,2000);
responses{3}.setDispDof(5,0.003);
responses{3}.setForceDof(3,2000);

simState = SimulationState();
network = Network(simState);
network.lbcbHost ='rp3267.cee.uiuc.edu';
network.lbcbPort =6342;
network.simcorPort =11999;
network.timeout = 4000;
network.setup();

gt = GetTargetStateMachine(network,network.simcorLink,simState);
gt.simcorSource = 1;
