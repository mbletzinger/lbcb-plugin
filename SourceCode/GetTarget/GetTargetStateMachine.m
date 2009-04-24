classdef GetTargetStateMachine < handle
    properties
        action = stateEnum({...
            'INITIALIZE SOURCE',...
            'GET TARGET'...
            });
        state = stateEnum({...
            'NO SOURCE',...
            'INITIALIZING SOURCE',...
            'SELECTED SOURCE',...
            'START SIMULATION',...
            'GETTING TARGET',...
            'EVALUATING STEP REDUCTION',...
            'EXECUTING TARGET',...
            'EXECUTING SUBSTEPS',...
            'REPORT RESPONSES',...
            'SIMULATION IS DONE',...
            'ERROR CONDITION'...
            });
        inputfiles = {};
        filenames = {};
        inputFilesUseModelCoordinates = 0;
        controlPointNodes = {};
        link ={};
        simcorSource = 0;
        substeps = stepReduction();
        target = {};
    end
    methods
        function me = GetTargetStateMachine(simState)
            config = configSimCorLink();
            me.controlPointNodes = config.controlPointNodes;
            me.link = simcorLink(simState,commandListener(config.localPort));
        end
        
        function execute(me,action)
            switch action
                case 'INITIALIZE SOURCE'
                    if me.simcorSource
                        me.state.setState('INITIALIZING SOURCE');
                        done = link.isConnected();
                        if done
                            me.state.setState('SELECTED SOURCE');
                        end
                    else
                        me.loadInputFiles();
                        me.state.setState('SELECTED SOURCE');
                    end
                case 'GET TARGET'
                          if me.simcorSource
                              link.getCommand()
                          end
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