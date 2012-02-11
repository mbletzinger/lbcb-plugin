classdef DebugWindow < DisplayControl
properties
    stpEx
    tgtEx
    prcsTgt
    targetPu
    stepPu
    processPu
    msgBox
    msgs
end
methods
    function me = DebugWindow()
        me.msgs = {'STARTED'};
    end
    function displayMe(me)
        me.fig = figure('DeleteFcn',{'DataDisplay.checkOff', 3 },...
            'Name','Debug Window','Position',[ 1 1 1080 634 ]);
        me.targetPu = uicontrol(me.fig,'Style','popupmenu','String',...
            me.tgtEx.currentAction.states,'Value',...
            me.tgtEx.currentAction.idx, 'Position', [ 82   438   217    55]);
        me.processPu = uicontrol(me.fig,'Style','popupmenu','String',...
            me.prcsTgt.currentAction.states,'Value',...
            me.prcsTgt.currentAction.idx, 'Position', [ 82   384   217    55]);
        me.stepPu = uicontrol(me.fig,'Style','popupmenu','String',...
            me.stpEx.currentAction.states,'Value',me.stpEx.currentAction.idx,...
            'Position', [ 82   311   217    55]);
        me.msgBox = uicontrol(me.fig,'Style','listbox','Position',...
            [ 82   2   1030    300]);
        me.isDisplayed = true;
    end
    function addMsg(me,msg)
        me.msgs = { me.msgs{:} msg};
        if me.isDisplayed
            set(me.msgBox,'String',me.msgs);
        end
    end
    function setTargetState(me,val)
        if me.isDisplayed
            set(me.targetPu, 'Value',val);
        end
    end
    function setProcessState(me,val)
        if me.isDisplayed
            set(me.processPu, 'Value',val);
        end
    end
    function setStepState(me,val)
        if me.isDisplayed
            set(me.stepPu, 'Value',val);
        end
    end
end
end