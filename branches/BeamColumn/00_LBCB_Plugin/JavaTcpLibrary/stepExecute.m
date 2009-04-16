classdef stepExecute < handle
    properties
        factory = {};
        sender = {};
        lbcb1 = {};
        lbcb2 = {};
        extTrans = {};
        extTransParams = {};
        lbcb1State = {};
        lbcb2State = {};
    end
    methods
        function me = stepExecute(factory,sender)
            me.factory = factory;
            me.sender = sender;
            [me.extTrans,lbcbGeos,me.extTransParams] = createExternalTransducerObjects();
            me.lbcb1State = externalTransducers2LbcbLocation(lbcbGeos{1});
            me.lbcb1State.reset();
            me.lbcb2State = externalTransducers2LbcbLocation(lbcbGeos{2});
            me.lbcb2State.reset();
        end
        function status = execute(targetL1,targetL2)
            me.lcbcb1 = lbcbReading();
            me.lcbcb2 = lbcbReading();
            msg = me.factory.createCommand('propose',targetL1.createMsg(),'LBCB1',1);
            status = sender.send(msg.msg);
            if(status.isState('NONE') == false)
                return;
            end
            msg = me.factory.createCommand('propose',targetL2.createMsg(),'LBCB2',1);
            status = sender.send(msg.msg);
            if(status.isState('NONE') == false)
                return;
            end
            msg = me.factory.createCommand('execute','',0,1);
            status = sender.send(msg.msg);
            if(status.isState('NONE') == false)
                return;
            end
            msg = me.factory.createCommand('get-control-point','dummy','LBCB1',0);
            status = sender.send(msg.msg);
            if(status.isState('NONE') == false)
                return;
            end
           me.lbcb1.parse(sender.response.getContent());
            msg = me.factory.createCommand('get-control-point','dummy','LBCB2',0);
            status = sender.send(msg.msg);
            if(status.isState('NONE') == false)
                return;
            end
           me.lbcb2.parse(sender.response.getContent());
            msg = me.factory.createCommand('get-control-point','dummy','ExternalSensors',0);
            status = sender.send(msg.msg);
            if(status.isState('NONE') == false)
                return;
            end
           values = parseExternalTransducersMsg(me.exTrans.names,sender.response.getContent());
           me.extTrans.update(values);
           lengths = me.lbcb1State.geometry.sensorValuesSubset(me.extTrans.currentLengths);
           me.lbcb1.ed.disp = ExtTrans2Cartesian(me.lbcb1State,me.extTransParams,lengths);

           lengths = me.lbcb2State.geometry.sensorValuesSubset(me.extTrans.currentLengths);
           me.lbcb2.ed.disp = ExtTrans2Cartesian(me.lbcb2State,me.extTransParams,lengths);
        end
    end
end