clear java
clear classes
clc
root = pwd

javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','UiSimCorJava-0.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'SourceCode','TcpLibrary'));

simState = SimulationState();
network = Network(simState);
network.lbcbHost ='rp3267.cee.uiuc.edu';
network.lbcbPort =6342;
network.setup();
notDone = 1;
while(notDone)
    done = network.isConnected('LBCB');
    [errorsExist errorMsg] = network.checkForErrors();
    if(done || errorsExist)
        notDone = 0;
        if(errorsExist)
            error = errorMsg{:}
        end
    end
    pause(2);
end

notDone = 1;
while(notDone)
    done = network.closeConnection('LBCB');
    [errorsExist errorMsg] = network.checkForErrors();
    errorsExist = 0;
    if(done || errorsExist)
        notDone = 0;
        if(errorsExist)
            errror = errorMsg{:}
        end
    end
    pause(2);
end
