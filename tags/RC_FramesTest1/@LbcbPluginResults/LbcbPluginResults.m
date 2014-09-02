classdef LbcbPluginResults < handle
    properties
        handles = [];
        hfact = [];
        stepHandles = cell(3,1);
        msgHandle = [];
        cmdTableHandle = [];
        triggerHandles = zeros(2,1)
        shuttingDown;
        tolerances;
        
        log = Logger('LbcbPluginResults');
        buttonStatus = StateEnum({...
            'ON',...
            'OFF',...
            'BROKEN'...
            });
        buttonName = StateEnum({...
            'CONNECT OM',...
            'CONNECT SIMCOR'...
            });
        lLabel = {'LBCB1' 'LBCB2'};
        dofLabel = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz' 'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz' };
        cmdTable
        ddisp
        bsimst
        bstpst
        bsrc
        bcor
        stats
    end
    methods
        function me  = LbcbPluginResults(handles,hfact)
            me.handles = handles;
            me.hfact = hfact;
            me.shuttingDown = false;
        end
        initialize(me)
        updateStepTolerances(me,st)
        updateStepsDisplay(me,simStep)
        updateCommandTable(me)
        colorButton(me,buttonName,bs)
        addMessage(me,msg)
        updateGui(me)
        updateCommands(me,ssd)
        blinkAcceptButton(me,on)
        colorAutoAcceptButton(me,on)
        colorRunButton(me,bs)
        menuCheck(me,menuName,isOn)
        updateStepState(me,idx)
        updateSimState(me,idx)
        updateSource(me,idx)        
        updateCorrections(me)        
    end
    methods (Access=private)
        colorFaultText(me,hndl,fault,isLbcb1,f)
        colorToleranceText(me,hndl,fault,isLbcb1,f)
    end
end