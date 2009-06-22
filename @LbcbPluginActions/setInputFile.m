function         setInputFile(me)
[file path] = uigetfile('*.txt','Input File');
iF = InputFile;
done = iF.load(fullfile(path,file));
if done
    me.nxtTgt.inpF = iF;
end
end