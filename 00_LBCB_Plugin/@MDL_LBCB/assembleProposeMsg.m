function send_str = assembleProposeMsg(me,tgt,transId,cps)

%tgt.curStep = tgt.curStep +1;         % increase current step number
send_str = sprintf('propose\t%s\tMDL-%02d-%02d:%s\t',transId,0,1,cps);

% temparary for CABER test
% tgt.T_Disp(2)=0; tgt.T_Disp(6)=0;

dofC = {'x' 'y' 'z'};
dofT = {'displacement' 'force';'rotation' 'moment'};

for i = 1:6
    cI =mod(i,3);
    if cI == 0 
        cI = 3;
    end
    
    dR = 1;
    
    if i > 3
        dR = 2;
    end
    
    tmp_str = '';
    
    if tgt.Cmd(i) == 2
        idxs = [cI dR 2]
        tmp_str = sprintf('%s\t%s\t%.10e\t',dofC{cI}, dofT{dR,2}, tgt.Forc(i));
    elseif tgt.Cmd(i) == 1
    idxs = [cI dR 1]
        tmp_str = sprintf('%s\t%s\t%.10e\t',dofC{cI}, dofT{dR,1}, tgt.Disp(i));
    end
    
    send_str = [send_str tmp_str];

end
send_str = send_str(1:end-1);                 			% Remove last tab
