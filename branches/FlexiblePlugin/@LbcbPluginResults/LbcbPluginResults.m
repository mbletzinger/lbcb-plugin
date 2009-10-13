classdef LbcbPluginResults < handle
    properties
        handles = [];
        cfg = [];
        %text box handles 1 = LBCB1, 2 = LBCB 2
        commandLimitsHandles1 = {};
        commandLimitsHandles2 = {};
        commandTolerancesHandles1 = {};
        commandTolerancesHandles2 = {};
        incrementLimitsHandles1 = {};
        incrementLimitsHandles2 = {};
        
        commandCurrentValueHandles1 = {};
        commandCurrentValueHandles2 = {};
        toleranceCurrentValueHandles1 = {};
        toleranceCurrentValueHandles2 = {};
        incrementCurrentValueHandles1 = {};
        incrementCurrentValueHandles2 = {};

        stepHandles = cell(2,1);
        
        log = Logger;
        buttonStatus = StateEnum({...
            'ON',...
            'OFF',...
            'BROKEN'...
            });
        
    end
    methods
        function me  = LbcbPluginActions(handles)
            me.handles = handles;
        end
        initialize(me)
        updateCommandLimits(me,cl)
        updateStepTolerances(me,st)
        updateStepsDisplay(me,simStep)
        colorRunButton(me,bs)
        colorConnectionButton(me,bs)
        addMessage(me,msg)
        updateGui(me)
        setGui(me,ingui)
    end
    methods (Access=private)
        colorFaultText(me,hndl,fault)
        colorToleranceText(me,hndl,fault)
        setLimit(me,hndl,dof,used,limit)
    end
end