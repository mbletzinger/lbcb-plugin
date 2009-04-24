classdef NetworkSettings < handle
    properties
        simcorPort = 0;
        triggerPort = 0;
        lbcbPort = 0;
        lbcbHost='';
        simState = {};
        simcorLink = {};
        lbcbLink={};
        triggerLink={};
        msgFactory = {};
        cmdSender = {};
        cmdListener = {};
    end
    methods
        function setupNetwork(me)
            config = ConfigNetworkSettings();
            me.msgFactory = MsgFactory(me.simState,config.controlPointNodes{1});
            me.cmdListener= CommandListener(me.simcorPort);
            me.cmdSender = CommandSender(me.lbcbHost,me.lbcbPort);
            me.simcorLink = SimCorLink(me.msgFactory,LinkStateMachine(me.cmdListener));
            me.lbcbLink = SimCorLink(me.msgFactory,LinkStateMachine(me.cmdSender));
        end
        function [errorsExist errorMsg] = checkForErrors(me)
            errorMsg = {};
            errorsExist = 0;
            i = 1;
            if(me.cmdSender.status.isStatus('NONE') == 0)
                errorMsg{i} = me.cmdSender.errorMsg;
                i = i + 1;
                errorsExist = 1;
            end
            if(me.cmdListener.status.isStatus('NONE') == 0)
                errorMsg{i} = me.cmdSender.errorMsg;
                errorsExist = 1;
            end
        end
    end
end