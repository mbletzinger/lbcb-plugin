function runInputFile(me,inFile)
me.nxtTgt.inpF = inFile;
me.nxtTgt.start();
ocfg = OmConfigDao(me.cfg);
me.fakeOm = ocfg.useFakeOm;
end
