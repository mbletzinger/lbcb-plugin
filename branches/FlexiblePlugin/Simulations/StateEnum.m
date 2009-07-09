% =====================================================================================================================
% Class that enables a MATLAB version of an enum type
%
% Members:
%   states - Cell array of strings which contain state labels.
%   idx - Indes to the current state.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef  StateEnum < handle
    properties
    states = { };
    idx = 1;
    end
    methods
        % Creates an instances the input argument states needs to be a cell
        % array ie. enum = StateEnum({'A','B','C'});
        function me = StateEnum(states)
            me.states = states;
            me.idx = 1;
        end
        % returns a label of the current state
        function state = getState(me)
            state = me.states{me.idx};
        end
        % Sets the state to the label in argument 'state'
        function setState(me,state)
            tmp = find(strcmp(me.states,state));
            if isempty(tmp)
                fprintf('ERROR: "%s" not found',state);
            end
            me.idx = tmp(1);
        end
        % Returns 1 if label in 'state' is the current state.  Returns 0
        % otherwise.
        function result = isState(me,state)
            result = strcmp(me.getState(),state);
        end
        % Sets the state to the label in argument 'state'
        function result = greaterThanOrEqualTo(me,state)
            tmp = find(strcmp(me.states,state));
            if isempty(tmp)
                result = 0;
                return;
            end
            result = me.idx >= tmp(1);
        end
    end
end