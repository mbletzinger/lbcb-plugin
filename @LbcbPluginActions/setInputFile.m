function         setInputFile(me,iF)
done = 1;
if isempty(iF)
    [file path] = uigetfile('*.txt','Input File');
    iF = InputFile;
    done = iF.load(fullfile(path,file));
end
if done
    me.nxtTgt.inpF = iF;
end
end