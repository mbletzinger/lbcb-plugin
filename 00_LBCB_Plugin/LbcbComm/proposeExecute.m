classdef proposeExecute < handle
    properties
        factory = {};
        lsm = {};
        targets = cell(2,1);
        readings = cell(3,1);
        receivePending = 0;
        state = stateEnum({...
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
        function me = proposeExecute(factory,linkState)
            me.factory = factory;
            me.lsm = linkState;
        end
        
        function setTarget(me,lbcb1,lbcb2)
            me.targets = {lbcb1, lbcb2};
        end
        
        function done = execute(me)
            done = 0;
            switch me.state.getState()
                case 'Send Target LBCB1'
                    if me.executeSendTarget(1)
                        me.state.setState('Send Target LBCB2');
                    end
                case 'Send Target LBCB2'
                    if me.executeSendTarget(0)
                        me.state.setState('Send Execute');
                    end
                case 'Send Execute'
                    if me.executeSendExecute()
                        me.state.setState('Get Control Point LBCB1');
                    end
                case 'Get Control Point LBCB1'
                    if me.executeGetControlPoint(1)
                        me.state.setState('Get Control Point LBCB2');
                    end
                case 'Get Control Point LBCB2'
                    if me.executeGetControlPoint(2)
                        me.state.setState('Get Control Point External Transducers');
                    end
                case 'Get Control Point External Transducers'
                    if me.executeGetControlPoint(2)
                        me.state.setState('Send Target LBCB1');
                        done = 1;
                    end
            end            
        end
        
        function sendMsg(me,command,cps,target)
            switch command
                case 'propose'
                    msg = me.factory.createCommand('propose',target.createMsg(),cps,1);
                case 'execute'
                    msg = me.factory.createCommand('execute','',0,1);
                case 'get-control-point'
                    msg = me.factory.createCommand('get-control-point','dummy',cps,0);
            end
            me.lsm.execute('SEND',msg.msg);
        end
        function reading = getReadings(me,cps)
            response = me.lsm.link.response.getContent();
            switch cps
                case {'LBCB1', 'LBCB2'}
                    reading = lbcbReading();
                    reading.parse(response);
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
                    else
                        me.receivePending = 1;
                        me.lsm.reset();
                        done = 1;
                    end
                case 'ERROR'
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
                    else
                        me.receivePending = 1;
                        me.lsm.reset();
                        done = 1;
                    end
                case 'ERROR'
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
                        me.sendMsg('get-control-point',me.targets{tgt},cpsNames{cpsIdx});
                    end
                case 'PENDING'
                    me.lsm.check();
                case 'DONE'
                    if me.receivePending
                        me.readings{cpsIdx} = me.getReadings(cpsNames{cpsIdx});
                        me.receivePending = 0;
                    else
                        me.receivePending = 1;
                        me.lsm.reset();
                        done = 1;
                    end
                case 'ERROR'
            end
        end
    end
end