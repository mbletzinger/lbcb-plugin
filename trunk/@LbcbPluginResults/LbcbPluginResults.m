classdef LbcbPluginResults < handle
    properties
        handles = [];
        hfact = [];
        stepHandles = cell(2,1);
        stepTimes = []; % BG
        msgHandle = [];
        cmdTableHandle = [];
        shuttingDown;
        alerts;
        tolerances;
        
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
        bcor
    end
    methods
        function me  = LbcbPluginResults(handles,hfact)
            me.handles = handles;
            me.hfact = hfact;
            me.shuttingDown = false;
            me.stepTimes = zeros(1,3);
        end
        initialize(me)
        updateAlerts(me)
        updateStepTolerances(me,st)
        updateStepsDisplay(me,simStep)
        updateTimer(me); %BG
        startTimer(me); %BG
        updateCommandTable(me)
        colorButton(me,buttonName,bs)
        addMessage(me,msg)
        updateGui(me)
        updateCommands(me,ssd)
        blinkAcceptButton(me,on)
        colorAutoAcceptButton(me,on)
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