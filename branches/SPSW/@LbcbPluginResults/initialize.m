function initialize(me)

if isempty(me.handles) == false
    me.tolerances = cell(2,1);
    for lbcb = 1:2
        me.tolerances{lbcb} = TolerancesConfigActions(me.hfact.st{lbcb});
        if lbcb == 1
            me.tolerances{lbcb}.initialize(me.handles.L1ToleranceTable);
        else
            me.tolerances{lbcb}.initialize(me.handles.L2ToleranceTable);
        end
    end
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