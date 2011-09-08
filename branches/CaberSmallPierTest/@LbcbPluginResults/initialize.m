function initialize(me)

if isempty(me.handles) == false
    me.alerts = AlertsBox();
    me.tolerances = TolerancesConfigActions(me.hfact.st);
    me.tolerances.initialize(me.handles);
    me.bsimst.init()
    me.bstpst.init()
    me.bsrc.init()
    me.bcor.init()

    Logger.setMsgHandle(me.handles.Messages);
    
    me.stepHandles{1} = me.handles.Step;
    me.stepHandles{2} = me.handles.SubStep;
    me.stepHandles{3} = me.handles.CorrectionStep;
    me.msgHandle = me.handles.Messages;
    me.cmdTableHandle = me.handles.CommandTable;
    titleIm = imread('ImagesAndSounds/LbcbPluginBanner.png');
    axes(me.handles.titleImage);
    image(titleIm);
    axis off;
    titleIm = imread('ImagesAndSounds/LBCB.png');
    axes(me.handles.lbcbImage);
    image(titleIm);
    axis off;
    titleIm = imread('ImagesAndSounds/UIUC_I.png');
    axes(me.handles.uiucImage);
    image(titleIm);
    axis off;
    me.updateSource(3);
    me.updateCorrections();
end
me.colorRunButton('OFF');
end