function obj = query(obj)

%MDLNames = cell(1);
MDLVals  = cell(1);

% Data from LBCB 1
send_str1 = sprintf('get-control-point\t%s\tMDL-%02d-%02d:LBCB1\tdummy',obj.TransID,0,1);
Sendvar_LabView(obj,send_str1);                           	% Send query command for control point j
[recv_str1] = Getvar_LabView(obj,obj.CMD.RPLY_PUT_DATA);  	% Receive data for control point j

% Data from LBCB 2
send_str2 = sprintf('get-control-point\t%s\tMDL-%02d-%02d:LBCB2\tdummy',obj.TransID,0,1);
Sendvar_LabView(obj,send_str2);                           	% Send query command for control point j
[recv_str2] = Getvar_LabView(obj,obj.CMD.RPLY_PUT_DATA);  	% Receive data for control point j

% External Measurement Data
send_str3 = sprintf('get-control-point\t%s\tMDL-%02d-%02d:ExternalSensors\tdummy',obj.TransID,0,1);
Sendvar_LabView(obj,send_str3);                           	% Send query command for control point j
[recv_str3] = Getvar_LabView(obj,obj.CMD.RPLY_PUT_DATA);  	% Receive data for control point j

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
recv = cell(46,1);

delimeter = sprintf(' \t');
while length(recv_str1)>0
        ind_i = ind_i+1;
        [token, recv_str1] = strtok(recv_str1,delimeter);
        recv{ind_i} = token;
end

%MDLNames{1} = recv{4};
%recv = recv(5:end);

for k=1:12
        MDLVals1{1}{k,1}=recv{(k-1)*3+2+4};
        MDLVals1{1}{k,2}=recv{(k-1)*3+1+4};
        MDLVals1{1}{k,3}=str2num(recv{(k-1)*3+3+4});
end

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
recv = cell(46,1);

delimeter = sprintf(' \t');
while length(recv_str2)>0
        ind_i = ind_i+1;
        [token, recv_str2] = strtok(recv_str2,delimeter);
        recv{ind_i} = token;
end

%MDLNames{1} = recv{4};
%recv = recv(5:end);

for k=1:12
        MDLVals2{1}{k,1}=recv{(k-1)*3+2+4};
        MDLVals2{1}{k,2}=recv{(k-1)*3+1+4};
        MDLVals2{1}{k,3}=str2num(recv{(k-1)*3+3+4});
end


% External Measurement Data
% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
recv = cell(46,1);

delimeter = sprintf(' \t');
while length(recv_str3)>0
        ind_i = ind_i+1;
        [token, recv_str3] = strtok(recv_str3,delimeter);
        recv{ind_i} = token;
end

%MDLNames{1} = recv{4};
%recv = recv(5:end);

for k=1:6
        AUXVals1{1}{k,1}=recv{(k-1)*3+2+4};
        AUXVals1{1}{k,2}=recv{(k-1)*3+1+4};
        AUXVals1{1}{k,3}=str2num(recv{(k-1)*3+3+4});
end

% Reformat data -------------------------------------------------------------------------------------------------------
for k=1:12
    switch MDLVals1{1}{k,1}
        case 'displacement'
            switch MDLVals1{1}{k,2}
                case 'x'
                    obj.M_Disp1(1) =MDLVals1{1}{k,3};
                case 'y'
                    obj.M_Disp1(2) =MDLVals1{1}{k,3};
                case 'z'
                    obj.M_Disp1(3) =MDLVals1{1}{k,3};
            end
        case 'rotation'
            switch MDLVals1{1}{k,2}
                case 'x'
                    obj.M_Disp1(4) =MDLVals1{1}{k,3};
                case 'y'
                    obj.M_Disp1(5) =MDLVals1{1}{k,3};
                case 'z'
                    obj.M_Disp1(6) =MDLVals1{1}{k,3};
            end
        case 'force'
            switch MDLVals1{1}{k,2}
                case 'x'
                    obj.M_Forc1(1) =MDLVals1{1}{k,3};
                case 'y'
                    obj.M_Forc1(2) =MDLVals1{1}{k,3};
                case 'z'
                    obj.M_Forc1(3) =MDLVals1{1}{k,3};
            end
        case 'moment'
            switch MDLVals1{1}{k,2}
                case 'x'
                    obj.M_Forc1(4) =MDLVals1{1}{k,3};
                case 'y'
                    obj.M_Forc1(5) =MDLVals1{1}{k,3};
                case 'z'
                    obj.M_Forc1(6) =MDLVals1{1}{k,3};
            end
    end
end


% Reformat data -------------------------------------------------------------------------------------------------------
for k=1:12
    switch MDLVals2{1}{k,1}
        case 'displacement'
            switch MDLVals2{1}{k,2}
                case 'x'
                    obj.M_Disp2(1) =MDLVals2{1}{k,3};
                case 'y'
                    obj.M_Disp2(2) =MDLVals2{1}{k,3};
                case 'z'
                    obj.M_Disp2(3) =MDLVals2{1}{k,3};
            end
        case 'rotation'
            switch MDLVals2{1}{k,2}
                case 'x'
                    obj.M_Disp2(4) =MDLVals2{1}{k,3};
                case 'y'
                    obj.M_Disp2(5) =MDLVals2{1}{k,3};
                case 'z'
                    obj.M_Disp2(6) =MDLVals2{1}{k,3};
            end
        case 'force'
            switch MDLVals2{1}{k,2}
                case 'x'
                    obj.M_Forc2(1) =MDLVals2{1}{k,3};
                case 'y'
                    obj.M_Forc2(2) =MDLVals2{1}{k,3};
                case 'z'
                    obj.M_Forc2(3) =MDLVals2{1}{k,3};
            end
        case 'moment'
            switch MDLVals2{1}{k,2}
                case 'x'
                    obj.M_Forc2(4) =MDLVals2{1}{k,3};
                case 'y'
                    obj.M_Forc2(5) =MDLVals2{1}{k,3};
                case 'z'
                    obj.M_Forc2(6) =MDLVals2{1}{k,3};
            end
    end
end

% Hussam, You need to modify this part with AUXVals1{1} and your string of external sensors
if ind_i>41
    for k=1:6
        switch AUXVals1{1}{k,1}
            case {'1_LBCB2_y','2_LBCB2_x_bot','3_LBCB2_x_top','4_LBCB1_y_left','5_LBCB1_y_right','6_LBCB1_x'}
                obj.M_AuxDisp1(k) =AUXVals1{1}{k,3};
            otherwise
                disp(sprintf('%s sensor name not recognized',AUXVals1{1}{k,1}));
        end
    end
end

% =====================================================================================================================
% This method query measured data from remote site.
%
% Input:
%       obj     : object of MDL_RF class
%       TGTD    : a vector with dimension, Num_DOF x 1
%
% Output:
%       obj     : updated object of MDL_RF class
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  1/17/2007 11:37PM OSK
% Last updated  1/22/2007 KSP for NHCP protocol
% =====================================================================================================================
%for i=1:length(obj)
%  updateGUI_Txt(obj,'Requesting result ...');
%    switch lower(obj.protocol)
%        case 'ntcp'                % when NTCP protocol is used
%            obj = Query_NTCP(obj);
%
%        case 'tcpip'               % when TCPIP1 protocol is used
%            obj = Query_TCPIP(obj);
%
%        case 'labview1'            % when LabView plugin is used
%            obj = Query_LabView1(obj);
%
%        case 'labview2'            % when TCPIP3 protocol is used
%            obj = Query_LabView2(obj);
%  
%        case 'openfresco1d'        % when OpenFresco1D protocol is used
%            obj = Query_OpenFresco1D(obj);
%        case {'nhcp'}
%            % Do nothing. The measured force is already received in 'ProposeQuery_NHCP'.
%        otherwise
%    end
    

  % Archive data for GUI -------------------------------------------------------------------------------------------------
%  if obj.EnableGUI                       % Enable simulation monitor?
%    end
    
%%%    % Apply coordinate transformation -------------------------------------------------------------------------------------
%%%    if ~isempty(obj.TransM)
%%%        obj.M_Disp = inv(obj.TransM)*obj.M_Disp;
%%%        obj.M_Forc = inv(obj.TransM)*obj.M_Forc;
%%%    end
%%%
%%%    % Apply scale factor to every modules
%%%    obj.M_Disp = obj.M_Disp .* (obj.DispScale.^-1);
%%%    obj.M_Forc = obj.M_Forc .* (obj.ForcScale.^-1);
%%%
    % Check tolerance ------------------------------------------------------------------------------------------------------
%    if obj.CheckLimit == 1
%        [accepted msg] = CheckTolrnc(obj);
%        if accepted==0
%            dispmsg(msg);
%      % uiwait(msgbox(msg,'Displacement tolerance check','warn','modal'));
%      switch questdlg(msg,'Displacement check','Continue','Abort','Continue');
%              case {'Abort'}
%                error('UI-SimCor terminated abnormally.');
%              otherwise
%            end
%        end
%    end

    % Correct measured force in case the measured disp is different from target disp ---------------------------------------
    % using initial stiffness matrix, I-modification
    %obj.M_Forc = obj.M_Forc - obj.K*(obj.M_Disp - obj.T_Disp);


    % Archive data for GUI -------------------------------------------------------------------------------------------------
%    if obj.EnableGUI                       % Enable simulation monitor?
%      obj.mDisp_history(obj.curStep,:) = obj.M_Disp;
%      obj.mForc_history(obj.curStep,:) = obj.M_Forc;
%    end
    
obj.curState = 3;
%    updateGUI_Txt(obj,'Result received.');
%    updateGUI_Fig(obj);
%
% fname = sprintf('LBCB_recv.txt');
% fid = fopen(fname,'a');
% fprintf(fid,'%05d  ',obj.curStep);
% fprintf(fid,'%+14.8e  ',obj.M_Disp);
% fprintf(fid,'%+14.8e  ',obj.M_Forc);
% fprintf(fid,'\r\n');
% fclose(fid);
%end