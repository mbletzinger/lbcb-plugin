classdef LbcbPluginResults < handle
    properties
        handles = [];
        hfact = [];
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
        msgHandle = [];
        cmdTableHandle = [];
        shuttingDown;
        
        log = Logger('LbcbPluginResults');
        buttonStatus = StateEnum({...
            'ON',...
            'OFF',...
            'BROKEN'...
            });
        buttonName = StateEnum({...
            'CONNECT OM',...
            'CONNECT SIMCOR',...
            'TRIGGER'...
            });
        lLabel = {'LBCB1' 'LBCB2'};
        dofLabel = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz' 'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz' };
        cmdTable
        ddisp
        bsimst
        bstpst
        bsrc

    end
    methods
        function me  = LbcbPluginResults(handles,hfact)
            me.handles = handles;
            me.hfact = hfact;
            me.shuttingDown = false;
        end
        initialize(me)
        updateLimits(me,cl,il)
        updateStepTolerances(me,st)
        updateStepsDisplay(me,simStep)
        updateCommandTable(me)
        colorButton(me,buttonName,bs)
        addMessage(me,msg)
        updateGui(me)
        updateCommands(me,ssd)
        blinkAcceptButton(me,on)
        setLimit(me,hndl,dof,used,limit)
        fillInLimits(me)
        colorAutoAcceptButton(me,on)
        updateStepState(me,idx)
        updateSimState(me,idx)
        updateSource(me,idx)        
    end
    methods (Access=private)
        colorFaultText(me,hndl,fault,isLbcb1,f)
        colorToleranceText(me,hndl,fault,isLbcb1,f)
    end
end