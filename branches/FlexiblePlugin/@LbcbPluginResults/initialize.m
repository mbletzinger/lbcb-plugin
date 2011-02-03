function initialize(me)

if isempty(me.handles) == 0
    me.commandLimitsHandles1 = cell(12,2);
    me.commandLimitsHandles1{1,1} = me.handles.DxL1;
    me.commandLimitsHandles1{2,1} = me.handles.DyL1;
    me.commandLimitsHandles1{3,1} = me.handles.DzL1;
    me.commandLimitsHandles1{4,1} = me.handles.RxL1;
    me.commandLimitsHandles1{5,1} = me.handles.RyL1;
    me.commandLimitsHandles1{6,1} = me.handles.RzL1;
    me.commandLimitsHandles1{7,1} = me.handles.FxL1;
    me.commandLimitsHandles1{8,1} = me.handles.FyL1;
    me.commandLimitsHandles1{9,1} = me.handles.FzL1;
    me.commandLimitsHandles1{10,1} = me.handles.MxL1;
    me.commandLimitsHandles1{11,1} = me.handles.MyL1;
    me.commandLimitsHandles1{12,1} = me.handles.MzL1;
    
    me.commandLimitsHandles1{1,2} = me.handles.DxU1;
    me.commandLimitsHandles1{2,2} = me.handles.DyU1;
    me.commandLimitsHandles1{3,2} = me.handles.DzU1;
    me.commandLimitsHandles1{4,2} = me.handles.RxU1;
    me.commandLimitsHandles1{5,2} = me.handles.RyU1;
    me.commandLimitsHandles1{6,2} = me.handles.RzU1;
    me.commandLimitsHandles1{7,2} = me.handles.FxU1;
    me.commandLimitsHandles1{8,2} = me.handles.FyU1;
    me.commandLimitsHandles1{9,2} = me.handles.FzU1;
    me.commandLimitsHandles1{10,2} = me.handles.MxU1;
    me.commandLimitsHandles1{11,2} = me.handles.MyU1;
    me.commandLimitsHandles1{12,2} = me.handles.MzU1;
    
    me.commandLimitsHandles2 = cell(12,2);
    me.commandLimitsHandles2{1,1} = me.handles.DxL2;
    me.commandLimitsHandles2{2,1} = me.handles.DyL2;
    me.commandLimitsHandles2{3,1} = me.handles.DzL2;
    me.commandLimitsHandles2{4,1} = me.handles.RxL2;
    me.commandLimitsHandles2{5,1} = me.handles.RyL2;
    me.commandLimitsHandles2{6,1} = me.handles.RzL2;
    me.commandLimitsHandles2{7,1} = me.handles.FxL2;
    me.commandLimitsHandles2{8,1} = me.handles.FyL2;
    me.commandLimitsHandles2{9,1} = me.handles.FzL2;
    me.commandLimitsHandles2{10,1} = me.handles.MxL2;
    me.commandLimitsHandles2{11,1} = me.handles.MyL2;
    me.commandLimitsHandles2{12,1} = me.handles.MzL2;
    
    me.commandLimitsHandles2{1,2} = me.handles.DxU2;
    me.commandLimitsHandles2{2,2} = me.handles.DyU2;
    me.commandLimitsHandles2{3,2} = me.handles.DzU2;
    me.commandLimitsHandles2{4,2} = me.handles.RxU2;
    me.commandLimitsHandles2{5,2} = me.handles.RyU2;
    me.commandLimitsHandles2{6,2} = me.handles.RzU2;
    me.commandLimitsHandles2{7,2} = me.handles.FxU2;
    me.commandLimitsHandles2{8,2} = me.handles.FyU2;
    me.commandLimitsHandles2{9,2} = me.handles.FzU2;
    me.commandLimitsHandles2{10,2} = me.handles.MxU2;
    me.commandLimitsHandles2{11,2} = me.handles.MyU2;
    me.commandLimitsHandles2{12,2} = me.handles.MzU2;
    
    
    me.commandCurrentValueHandles1 = cell(12,1);
    me.commandCurrentValueHandles1{1} = me.handles.DxCV1;
    me.commandCurrentValueHandles1{2} = me.handles.DyCV1;
    me.commandCurrentValueHandles1{3} = me.handles.DzCV1;
    me.commandCurrentValueHandles1{4} = me.handles.RxCV1;
    me.commandCurrentValueHandles1{5} = me.handles.RyCV1;
    me.commandCurrentValueHandles1{6} = me.handles.RzCV1;
    me.commandCurrentValueHandles1{7} = me.handles.FxCV1;
    me.commandCurrentValueHandles1{8} = me.handles.FyCV1;
    me.commandCurrentValueHandles1{9} = me.handles.FzCV1;
    me.commandCurrentValueHandles1{10} = me.handles.MxCV1;
    me.commandCurrentValueHandles1{11} = me.handles.MyCV1;
    me.commandCurrentValueHandles1{12} = me.handles.MzCV1;
    
    me.commandCurrentValueHandles2 = cell(12,1);
    me.commandCurrentValueHandles2{1} = me.handles.DxCV2;
    me.commandCurrentValueHandles2{2} = me.handles.DyCV2;
    me.commandCurrentValueHandles2{3} = me.handles.DzCV2;
    me.commandCurrentValueHandles2{4} = me.handles.RxCV2;
    me.commandCurrentValueHandles2{5} = me.handles.RyCV2;
    me.commandCurrentValueHandles2{6} = me.handles.RzCV2;
    me.commandCurrentValueHandles2{7} = me.handles.FxCV2;
    me.commandCurrentValueHandles2{8} = me.handles.FyCV2;
    me.commandCurrentValueHandles2{9} = me.handles.FzCV2;
    me.commandCurrentValueHandles2{10} = me.handles.MxCV2;
    me.commandCurrentValueHandles2{11} = me.handles.MyCV2;
    me.commandCurrentValueHandles2{12} = me.handles.MzCV2;
    
    me.commandTolerancesHandles1 = cell(12,1);
    me.commandTolerancesHandles1{1} = me.handles.DxT1;
    me.commandTolerancesHandles1{2} = me.handles.DyT1;
    me.commandTolerancesHandles1{3} = me.handles.DzT1;
    me.commandTolerancesHandles1{4} = me.handles.RxT1;
    me.commandTolerancesHandles1{5} = me.handles.RyT1;
    me.commandTolerancesHandles1{6} = me.handles.RzT1;
    me.commandTolerancesHandles1{7} = me.handles.FxT1;
    me.commandTolerancesHandles1{8} = me.handles.FyT1;
    me.commandTolerancesHandles1{9} = me.handles.FzT1;
    me.commandTolerancesHandles1{10} = me.handles.MxT1;
    me.commandTolerancesHandles1{11} = me.handles.MyT1;
    me.commandTolerancesHandles1{12} = me.handles.MzT1;
    
    me.commandTolerancesHandles2 = cell(12,1);
    me.commandTolerancesHandles2{1} = me.handles.DxT2;
    me.commandTolerancesHandles2{2} = me.handles.DyT2;
    me.commandTolerancesHandles2{3} = me.handles.DzT2;
    me.commandTolerancesHandles2{4} = me.handles.RxT2;
    me.commandTolerancesHandles2{5} = me.handles.RyT2;
    me.commandTolerancesHandles2{6} = me.handles.RzT2;
    me.commandTolerancesHandles2{7} = me.handles.FxT2;
    me.commandTolerancesHandles2{8} = me.handles.FyT2;
    me.commandTolerancesHandles2{9} = me.handles.FzT2;
    me.commandTolerancesHandles2{10} = me.handles.MxT2;
    me.commandTolerancesHandles2{11} = me.handles.MyT2;
    me.commandTolerancesHandles2{12} = me.handles.MzT2;
    
    
    me.toleranceCurrentValueHandles1 = cell(12,1);
    me.toleranceCurrentValueHandles1{1} = me.handles.DxTCV1;
    me.toleranceCurrentValueHandles1{2} = me.handles.DyTCV1;
    me.toleranceCurrentValueHandles1{3} = me.handles.DzTCV1;
    me.toleranceCurrentValueHandles1{4} = me.handles.RxTCV1;
    me.toleranceCurrentValueHandles1{5} = me.handles.RyTCV1;
    me.toleranceCurrentValueHandles1{6} = me.handles.RzTCV1;
    me.toleranceCurrentValueHandles1{7} = me.handles.FxTCV1;
    me.toleranceCurrentValueHandles1{8} = me.handles.FyTCV1;
    me.toleranceCurrentValueHandles1{9} = me.handles.FzTCV1;
    me.toleranceCurrentValueHandles1{10} = me.handles.MxTCV1;
    me.toleranceCurrentValueHandles1{11} = me.handles.MyTCV1;
    me.toleranceCurrentValueHandles1{12} = me.handles.MzTCV1;
    
    me.toleranceCurrentValueHandles2 = cell(12,1);
    me.toleranceCurrentValueHandles2{1} = me.handles.DxTCV2;
    me.toleranceCurrentValueHandles2{2} = me.handles.DyTCV2;
    me.toleranceCurrentValueHandles2{3} = me.handles.DzTCV2;
    me.toleranceCurrentValueHandles2{4} = me.handles.RxTCV2;
    me.toleranceCurrentValueHandles2{5} = me.handles.RyTCV2;
    me.toleranceCurrentValueHandles2{6} = me.handles.RzTCV2;
    me.toleranceCurrentValueHandles2{7} = me.handles.FxTCV2;
    me.toleranceCurrentValueHandles2{8} = me.handles.FyTCV2;
    me.toleranceCurrentValueHandles2{9} = me.handles.FzTCV2;
    me.toleranceCurrentValueHandles2{10} = me.handles.MxTCV2;
    me.toleranceCurrentValueHandles2{11} = me.handles.MyTCV2;
    me.toleranceCurrentValueHandles2{12} = me.handles.MzTCV2;
    
    me.incrementLimitsHandles1 = cell(12,1);
    me.incrementLimitsHandles1{1} = me.handles.DxI1;
    me.incrementLimitsHandles1{2} = me.handles.DyI1;
    me.incrementLimitsHandles1{3} = me.handles.DzI1;
    me.incrementLimitsHandles1{4} = me.handles.RxI1;
    me.incrementLimitsHandles1{5} = me.handles.RyI1;
    me.incrementLimitsHandles1{6} = me.handles.RzI1;
    me.incrementLimitsHandles1{7} = me.handles.FxI1;
    me.incrementLimitsHandles1{8} = me.handles.FyI1;
    me.incrementLimitsHandles1{9} = me.handles.FzI1;
    me.incrementLimitsHandles1{10} = me.handles.MxI1;
    me.incrementLimitsHandles1{11} = me.handles.MyI1;
    me.incrementLimitsHandles1{12} = me.handles.MzI1;
    
    me.incrementLimitsHandles2 = cell(12,1);
    me.incrementLimitsHandles2{1} = me.handles.DxI2;
    me.incrementLimitsHandles2{2} = me.handles.DyI2;
    me.incrementLimitsHandles2{3} = me.handles.DzI2;
    me.incrementLimitsHandles2{4} = me.handles.RxI2;
    me.incrementLimitsHandles2{5} = me.handles.RyI2;
    me.incrementLimitsHandles2{6} = me.handles.RzI2;
    me.incrementLimitsHandles2{7} = me.handles.FxI2;
    me.incrementLimitsHandles2{8} = me.handles.FyI2;
    me.incrementLimitsHandles2{9} = me.handles.FzI2;
    me.incrementLimitsHandles2{10} = me.handles.MxI2;
    me.incrementLimitsHandles2{11} = me.handles.MyI2;
    me.incrementLimitsHandles2{12} = me.handles.MzI2;
    
    
    me.incrementCurrentValueHandles1 = cell(12,1);
    me.incrementCurrentValueHandles1{1} = me.handles.DxICV1;
    me.incrementCurrentValueHandles1{2} = me.handles.DyICV1;
    me.incrementCurrentValueHandles1{3} = me.handles.DzICV1;
    me.incrementCurrentValueHandles1{4} = me.handles.RxICV1;
    me.incrementCurrentValueHandles1{5} = me.handles.RyICV1;
    me.incrementCurrentValueHandles1{6} = me.handles.RzICV1;
    me.incrementCurrentValueHandles1{7} = me.handles.FxICV1;
    me.incrementCurrentValueHandles1{8} = me.handles.FyICV1;
    me.incrementCurrentValueHandles1{9} = me.handles.FzICV1;
    me.incrementCurrentValueHandles1{10} = me.handles.MxICV1;
    me.incrementCurrentValueHandles1{11} = me.handles.MyICV1;
    me.incrementCurrentValueHandles1{12} = me.handles.MzICV1;
    
    me.incrementCurrentValueHandles2 = cell(12,1);
    me.incrementCurrentValueHandles2{1} = me.handles.DxICV2;
    me.incrementCurrentValueHandles2{2} = me.handles.DyICV2;
    me.incrementCurrentValueHandles2{3} = me.handles.DzICV2;
    me.incrementCurrentValueHandles2{4} = me.handles.RxICV2;
    me.incrementCurrentValueHandles2{5} = me.handles.RyICV2;
    me.incrementCurrentValueHandles2{6} = me.handles.RzICV2;
    me.incrementCurrentValueHandles2{7} = me.handles.FxICV2;
    me.incrementCurrentValueHandles2{8} = me.handles.FyICV2;
    me.incrementCurrentValueHandles2{9} = me.handles.FzICV2;
    me.incrementCurrentValueHandles2{10} = me.handles.MxICV2;
    me.incrementCurrentValueHandles2{11} = me.handles.MyICV2;
    me.incrementCurrentValueHandles2{12} = me.handles.MzICV2;
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
    
    me.fillInLimits();
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
    me.updateCorrections(false,false,false);
end
me.colorRunButton('OFF');
end