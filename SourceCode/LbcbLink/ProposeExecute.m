classdef ProposeExecute < handle
    properties
        factory = {};
        lsm = {};
        targets = cell(2,1);
        readings = cell(3,1);
        receivePending = 0;
        numberOfTimeouts = 0;
        timeoutMultiplier= 0;
        state = StateEnum({...
            'Send Target LBCB1',...
            'Send Target LBCB2',...
            'Send Execute',...
            'Get Control Point LBCB1',...
            'Get Control Point LBCB2',...
            'Get Control Point External Transducers',...
            'Done'...
            });
   end
    methods
        function me = ProposeExecute(factory,lsm)
            me.factory = factory;
            me.lsm = lsm;
            config = ConfigNetworkSettings();
            me.timeoutMultiplier = config.multiplier;
        end
        
        function setTargets(me,targets)
            me.targets = targets;
        end
        
        function done = execute(me)
            done = 0;
            me.state.getState()
            switch me.state.getState()
                case 'Send Target LBCB1'
                    if me.executeSendTarget(1)
                        me.state.setState('Send Target LBCB2');
                        me.receivePending = 0;
                    end
                case 'Send Target LBCB2'
                    if me.executeSendTarget(0)
                        me.state.setState('Send Execute');
                        me.receivePending = 0;
                    end
                case 'Send Execute'
                    if me.executeSendExecute()
                        me.state.setState('Get Control Point LBCB1');
                        me.receivePending = 0;
                    end
                case 'Get Control Point LBCB1'
                    if me.executeGetControlPoint(1)
                        me.state.setState('Get Control Point LBCB2');
                        me.receivePending = 0;
                    end
                case 'Get Control Point LBCB2'
                    if me.executeGetControlPoint(2)
                        me.state.setState('Get Control Point External Transducers');
                        me.receivePending = 0;
                    end
                case 'Get Control Point External Transducers'
                    if me.executeGetControlPoint(2)
                        me.state.setState('Send Target LBCB1');
                        me.receivePending = 0;
                        done = 1;
                    end
            end
        end
        
        function sendMsg(me,command,target,cps)
            switch command
                case 'propose'
                    msg = me.factory.createCommand('propose',target.createMsg(),cps,1);
                case 'execute'
                    msg = me.factory.createCommand('execute','',0,1);
                case 'get-control-point'
                    msg = me.factory.createCommand('get-control-point','dummy',cps,0);
                otherwise
                    error = scanf('%s not recognized',command)
            end
            me.lsm.execute('SEND',msg.jmsg);
        end
        function reading = getReadings(me,cps)
            response = char(me.lsm.link.response.getContent());
            node = char(me.lsm.link.response.getNode());
            switch cps
                case {'LBCB1', 'LBCB2'}
                    reading = LbcbReading();
                    reading.parse(response,node);
                case 'ExternalTransducers'
                    reading = parseExternalTransducers(response);
            end
        end
        
        function done = executeSendTarget(me,isLbcb1)
            if isLbcb1
                cps = 'LBCB1';
                tgt= 1;
            else
                cps = 'LBCB2';
                tgt= 2;
            end
            done = 0;
            me.lsm.state.getState()
            me.receivePending
            switch me.lsm.state.getState()
                case 'READY'
                    if me.receivePending
                        me.lsm.execute('RECEIVE');
                    else
                        me.sendMsg('propose',me.targets{tgt},cps);
                    end
                case 'PENDING'
                    me.lsm.check();
                case 'DONE'
                    if me.receivePending
                        me.receivePending = 0;
                        done = 1;
                    else
                        me.receivePending = 1;
                    end
                    me.lsm.reset();
                case 'ERROR'
                    me.clearTimeoutErrors();
            end
        end
        
        function done = executeSendExecute(me)
            done = 0;
            switch me.lsm.state.getState()
                case 'READY'
                    if me.receivePending
                        me.lsm.execute('RECEIVE');
                    else
                        me.sendMsg('execute',{},'');
                    end
                case 'PENDING'
                    me.lsm.check();
                case 'DONE'
                    if me.receivePending
                        me.receivePending = 0;
                        done = 1;
                    else
                        me.receivePending = 1;
                    end
                        me.lsm.reset();
                case 'ERROR'
                    me.clearTimeoutErrors();
            end
        end
        
        function done = executeGetControlPoint(me,cpsIdx)
            cpsNames = {'LBCB1','LBCB2','ExternalTransducers'};
            done = 0;
            switch me.lsm.state.getState()
                case 'READY'
                    if me.receivePending
                        me.lsm.execute('RECEIVE');
                    else
                        me.sendMsg('get-control-point',{},cpsNames{cpsIdx});
                    end
                case 'PENDING'
                    me.lsm.check();
                case 'DONE'
                    if me.receivePending
                        me.readings{cpsIdx} = me.getReadings(cpsNames{cpsIdx});
                        me.receivePending = 0;
                        done = 1;
                    else
                        me.receivePending = 1;
                    end
                        me.lsm.reset();
                case 'ERROR'
                    me.clearTimeoutErrors();
            end
        end
        
        function clearTimeoutErrors(me)
            status = me.lsm.link.getResponse();
            switch status.getState()
                case 'NONE'
                    me.numberOfTimeouts = 0;
                case 'IO_ERROR'
                    if me.numberOfTimeouts < me.timeoutMultiplier
                        me.numberOfTimeouts = me.numberOfTimeouts + 1;
                        me.lsm.status.setState('NONE');
                    end
            end
        end
    end
end