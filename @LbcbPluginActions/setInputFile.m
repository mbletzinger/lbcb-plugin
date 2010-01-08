function         setInputFile(me,iF)
done = 1;
if isempty(iF)
    [file path] = uigetfile('*.txt','Input File');
    iF = me.hfact.inF;
    done = iF.load(fullfile(path,file));
end
if done
    me.hfact.tgtEx.inF = iF;
    me.hfact.tgtEx.targetSource.setState('INPUT FILE');
else
    me.hfact.tgtEx.targetSource.setState('NONE');
    
end
end