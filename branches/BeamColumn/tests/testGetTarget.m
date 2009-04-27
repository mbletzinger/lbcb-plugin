function testGetTarget(gt, network,action)
notDone = 1;
 gt.execute(action);
while(notDone)
    gt.state.getState()
    done = gt.isDone();
    [errorsExist errorMsg] = network.checkForErrors();
    if(done || errorsExist)
        notDone = 0;
        if(errorsExist)
            char(errorMsg)
        end
        notDone = 0;
    end
    pause(0.5);
end
end