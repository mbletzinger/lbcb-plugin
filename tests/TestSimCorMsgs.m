clear java
clear classes
clc
root = pwd

javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary'));

responses = {LbcbReading(), LbcbReading};

responses{1}.disp(1) = 0.003;
responses{2}.disp(4) = 0.003;
responses{1}.force(2) = 35;
responses{2}.force(6) = 2000;

simState = SimulationState();
network = Network(simState);
network.lbcbHost ='rp3267.cee.uiuc.edu';
network.lbcbPort =6342;
network.simcorPort =6343;
network.setup();
notDone = 1;

gt = GetTargetStateMachine(network.factory,network.simcorLink);

testGetTarget(gt,network,'INITIALIZING SOURCE');

gt.response = responses;
while(notDone)
    notDone = testGetTarget(gt,network,'TARGET REQUESTED');
    testGetTarget(gt,network,'SEND RESPONSE');
end

notDone = 1;
while(notDone)
    done = network.closeConnection('LBCB');
    [errorsExist errorMsg] = network.checkForErrors();
    errorsExist = 0;
    if(done || errorsExist)
        notDone = 0;
        if(errorsExist)
            char(errorMsg)
        end
    end
    pause(0.5);
end

