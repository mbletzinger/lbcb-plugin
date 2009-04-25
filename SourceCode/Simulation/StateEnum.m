classdef  StateEnum < handle
    properties
    states = { };
    idx = 1;
    end
    methods
        function me = StateEnum(states)
            me.states = states;
            me.idx = 1;
        end
        function state = getState(me)
            state = me.states{me.idx};
        end
        function setState(me,state)
            tmp = find(strcmp(me.states,state));
            me.idx = tmp(1);
        end
        function result = isState(state)
            result = strcmp(getState(),state);
        end
    end
end