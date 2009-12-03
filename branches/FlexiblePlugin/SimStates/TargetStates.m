classdef TargetStates < SimStates
    properties
        currentAction = StateEnum({...
            'WAIT FOR TARGET',...
            'GET TARGET',...
            'EXECUTE SUBSTEPS',...
            'SEND TARGET RESPONSE',...
            'DONE'
            });
        state = StateEnum({...
            'BUSY',...
            'COMPLETED',...
            'ERRORS EXIST'...
            });
        targetSource = StateEnum({...
            'INPUT FILE',...
            'UI SIMCOR',...
            });
        stpEx = [];
        inF = [];
    end
    methods
        function start(me)
            me.currentAction.setState('WAIT FOR TARGET');
        end
        function done = isDone(me)
            done = 0;
            me.log.debug(dbstack,sprintf('Executing %s',me.currentAction.getState()));
            switch me.currentAction.getState()
                case 'WAIT FOR TARGET'
                    me.waitForTarget();
                case 'GET TARGET'
                    me.getTarget();
                case 'EXECUTE SUBSTEPS'
                    me.executeSubsteps();
                case 'SEND TARGET RESPONSE'
                    me.sendTargetResponses();
                case 'DONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
    end
    methods (Access='private')
        function waitForTarget(me)
            if me.targetSource.isState('INPUT FILE')
                if me.inF.endOfFile
                    me.currentAction.setState('DONE');
                else
                me.currentAction.setState('GET TARGET');
                end
                return;
            end
        end
        function getTarget(me)
            if me.targetSource.isState('INPUT FILE')
                me.dat.curTarget = me.inF.next();
                me.dat.curTarget.transformCommand();
                steps = me.splitTarget();
                me.currentAction.setState('EXECUTE SUBSTEPS');
                me.stpEx.start(steps);
            end
        end
        function steps = splitTarget(me)
            steps = Substeps();
            if me.cdp.doStepSplitting == false
                steps.steps = { me.dat.curTarget };
                return;
            end
            stpSize = ones(24,1);  % hack around divide by zero problem
            stpSize(1:6) = me.cdp.getSubstepInc(1);
            stpSize(7:12) = me.cdp.getSubstepInc(0);
            [ initialDisp initialDispDofs initialForce initialForceDofs ] = ...
                me.dat.prevTarget.cmdData();
            [ finalDisp finalDispDofs finalForce finalForceDofs ] = ...
                me.dat.curTarget.cmdData(); %#ok<ASGLU,NASGU>
            numSteps = (finalDisp - initialDisp) / stpSize;
            [m, maxNumSteps] = max(numSteps); %#ok<ASGLU>
            inc = (finalDisp - initialDisp) / maxNumSteps;
            finc = (finalForce - initialForce) / maxNumSteps;
            ss = cell(maxNumSteps,1);
            disp = initialDisp;
            force = intialForce;
            for i = 1 : maxNumSteps
                prevDisp = disp;
                prevForce = force;
                disp = prevDisp + inc;
                force = prevForce + finc;
                tgts{1}.disp = disp(1:6); %#ok<*AGROW>
                tgts{1}.dispDofs = initialDispDofs(1:6);
                tgts{1}.force = force(1:6);
                tgts{1}.forceDofs = initialForceDofs(1:6);
                if cdp.numLbcbs > 1
                    tgts{2}.disp = disp(7:12);
                    tgts{2}.dispDofs = initialDispDofs(7:12);
                    tgts{2}.force = force(7:12);
                    tgts{2}.forceDofs = initialForceDofs(7:12);
                end
                ss{i} = me.sdf.target2StepData(tgts);
                
            end
            steps.steps = ss;
        end
        function executeSubsteps(me)
            if me.stpEx.isDone() == false
                return;
            end
            me.currentAction.setState('SEND TARGET RESPONSE');            
        end
        function sendTargetResponses(me)
             if me.targetSource.isState('INPUT FILE')
                me.dat.prevTarget = me.dat.curTarget;
                me.dat.prevTarget.transformResponse();
                me.currentAction.setState('WAIT FOR TARGET');
            end
       end
    end
end