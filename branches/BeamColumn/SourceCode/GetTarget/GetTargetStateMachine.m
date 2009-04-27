classdef GetTargetStateMachine < handle
    properties
        action = stateEnum({...
            'INITIALIZE SOURCE',...
            'GET TARGET'...
            'SEND RESPONSE',...
            });
        state = stateEnum({...
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
        link ={};
        simcorSource = 0;
        substeps = stepReduction();
        target = {};
        sessionClosing = 0;
        factory = {};
        simState = 0;
        response = {};
    end
    methods
        function me = GetTargetStateMachine(factory,lsm,simState)
            config = ConfigSimCorLink();
            me.controlPointNodes = config.controlPointNodes;
            me.link = lsm;
            me.factory = factory;
            me.simState = simState;
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
                    error = sprintf('%s not recognized',action)
            end
        end

        function done = isDone(me)
            switch me.state.getState()
                case 'INITIALIZING SOURCE'
                    done = network.isConnected('UI-SIMCOR');
                    if done
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
                                cnt = me.lsm.link.command.getContent();
                                nd = me.lsm.link.command.getNode();
                                me.command = m2d.parse(cnt,nd);
                                me.state.setState('TARGET READY');
                            case 'close-session'
                                rsp = me.factory.createResponse('Close accepted','',me.lsm.link.command);
                                me.lsm.execute('SEND',rsp);
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
                    rsp = me.factory.createResponse(cnt,'',me.lsm.link.command);
                    me.lsm.execute('SEND',rsp);
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
                otherwise
                    error = sprintf('%s not recognized',me.state.getState())
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
                me.inputfiles{i} = inputFile();
                me.inputfiles{i}.load(me.filenames{i});
            end
        end
     end
end