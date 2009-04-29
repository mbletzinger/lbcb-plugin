function done = testGetTarget(gt, network,action)
notDone = 1;
done = 0;
gt.execute(action);
while(notDone)
    gt.state.getState()
    done = gt.isDone();
    [errorsExist errorMsg] = network.checkForErrors();
    if(done || errorsExist)
        notDone = 0;
        if(errorsExist)
            errorMsg
        end
        notDone = 0;
    end
    pause(0.5);
    if gt.sessionClosing
        done = 1;
        notDone = 0;
    end
end
end