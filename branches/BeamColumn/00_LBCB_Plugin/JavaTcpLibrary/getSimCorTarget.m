classdef getSimCorTarget < handle
    properties
        factory = {};
        lsm = {};
        targets = cell(2,1);
        readings = cell(3,1);
        receivePending = 0;
   end
    methods
        function me = getSimCorTarget(factory,linkState)
            me.factory = factory;
            me.lsm = linkState;
        end
        
        function setTarget(me,lbcb1,lbcb2)
            me.targets = {lbcb1, lbcb2};
        end
        
        function done = execute(me)
            done = 0;
            switch me.lsm.state.getState()
                case 'READY'
                    if me.receivePending
                        me.lsm.execute('RECEIVE');
                    else
                        me.lsm.execute('SEND');
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
                case 'EsxternalTransducers'
                    reading = parseExternalTransducers(response);
            end
        end
        
        
        function done = executeGetControlPoint(me,cpsIdx)
        end
    end
end