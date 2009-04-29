classdef GetTargetStateMachine < handle
    properties
        action = StateEnum({...
            'INITIALIZE SOURCE',...
            'GET TARGET'...
            'SEND RESPONSE',...
            });
        state = StateEnum({...
            'INITIALIZING SOURCE',...
            'SOURCE READY',...
            'TARGET REQUESTED',...
            'GETTING TARGET',...
            'TARGET READY',...
            'RESPONSE AVAILABLE',...
            'SENDING RESPONSE',...
            'SESSION IS CLOSING',...
            'SESSION HAS CLOSED',...
            'NO SOURCE'...
            });
        inputfiles = {};
        filenames = {};
        inputFilesUseModelCoordinates = 0;
        controlPointNodes = {};
        lsm ={};
        simcorSource = 0;
        substeps = StepReduction();
        targets = {};
        sessionClosing = 0;
        network = {};
        simState = 0;
        response = {};
        m2d = Msg2DofData();
    end
    methods
        function me = GetTargetStateMachine(network,lsm,simState)
            config = ConfigNetworkSettings();
            me.controlPointNodes = config.controlPointNodes;
            me.lsm = lsm;
            me.network = network;
            me.simState = simState;
            me.simcorSource = config.useSimCor;
        end
        
        function execute(me,action)
            switch action
                case 'INITIALIZE SOURCE'
                    if me.simcorSource
                        me.state.setState('INITIALIZING SOURCE');
                    else
                        me.loadInputFiles();
                        me.state.setState('SOURCE READY');
                    end
                case 'GET TARGET'
                        me.state.setState('TARGET REQUESTED');
                case 'SEND RESPONSE'
                        me.state.setState('RESPONSE AVAILABLE');
                otherwise
                    error = sprintf('action [%s] not recognized',action)
            end
        end

        function done = isDone(me)
            done = 0;
            switch me.state.getState()
                case 'INITIALIZING SOURCE'
                    d = me.network.isConnected('UI-SIMCOR');
                    if d
                        me.state.setState('SOURCE READY');
                    end
                case 'SOURCE READY'
                    done = 1;
                case 'TARGET REQUESTED'
                    me.lsm.execute('RECEIVE');
                    me.state.setState( 'GETTING TARGET');
                case 'GETTING TARGET'
                    d = me.lsm.check();
                    if d
                        cmd = char(me.lsm.link.command.getCommand());
                        switch cmd
                            case 'propose'
                                cnt = char(me.lsm.link.command.getContent());
                                nd = char(me.lsm.link.command.getNode());
                                me.targets = me.m2d.parse(cnt,nd);
                                me.state.setState('TARGET READY');
                            case 'close-session'
                                rsp = me.network.factory.createResponse('Close accepted',me.lsm.link.command);
                                me.lsm.execute('SEND',rsp.jmsg);
                                me.state.setState('SESSION IS CLOSING');
                        end
                    end
                case 'TARGET READY'
                    done = 1;
                case 'RESPONSE AVAILABLE'
                    cnt = '';
                    for t = 1: length(me.response)
                        if t > 1
                            cnt = sprintf('%s\t%s\t%s',cnt,me.response{t}.node,me.response{t}.createMsg());
                        else
                            cnt = sprintf('%s\t%s',cnt,me.response{t}.createMsg());
                        end
                    end
                    rsp = me.network.factory.createResponse(cnt,me.lsm.link.command);
                    me.lsm.execute('SEND',rsp.jmsg);
                    me.state.setState( 'SENDING RESPONSE');
                case 'SENDING RESPONSE'
                    d = me.lsm.check();
                    if d
                        me.state.setState( 'SOURCE READY');
                    end
                case 'SESSION IS CLOSING'
                    d = me.lsm.check();
                    if d
                        me.state.setState('SESSION HAS CLOSED');
                    end
                case 'SESSION HAS CLOSED'
                    done = 1;
                    me.sessionClosing = 1;
                otherwise
                    error = sprintf('state [%s] not recognized',me.state.getState())
            end
        end

        function loadInputFiles(me)
            if me.inputFilesUseModelCoordinates
                numNodes = length(me.controlPointNodes);
            else
                numNodes = 2;
            end
            me.inputfiles = cell(numNodes,1);
            for i = 1:numNodes
                me.inputfiles{i} = InputFile();
                me.inputfiles{i}.load(me.filenames{i});
            end
        end
     end
end