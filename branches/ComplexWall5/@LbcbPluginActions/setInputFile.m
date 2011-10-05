function         setInputFile(me,iF)
done = 1;
if isempty(iF)
    [file path] = uigetfile('*.txt','Input File');
    iF = me.hfact.inF;
    strtStep = [];
    while isempty(strtStep)
        a = inputdlg('Starting Step Number?','Starting Step Number',1,{'1'});
        strtStep = sscanf(a{1},'%d');
    end
    done = iF.load(fullfile(path,file),strtStep);
end
me.currentSimExecute.setState('DONE');
if done
    me.hfact.tgtEx.inF = iF;
    me.hfact.tgtEx.targetSource.setState('INPUT FILE');
    me.hfact.gui.updateSource(1);
    me.alreadyStarted = false;
else
    me.hfact.tgtEx.targetSource.setState('NONE');
    
end
end