function obj = query(obj)

MDLVals  = cell(1);

% cd('..');
% cd('Output Files');
send_str = sprintf('get-control-point\tdummy\tMDL-%02d-%02d',0,1);
Sendvar_LabView(obj,send_str);                           		% Send query command for control point j
[recv_str] = Getvar_LabView(obj,obj.CMD.RPLY_PUT_DATA);  		% Receive data for control point j
% cd('..');
% cd('Support Files');

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
recv = cell(55,1);

delimeter = sprintf(' \t');
while length(recv_str)>0
        ind_i = ind_i+1;
        [token, recv_str] = strtok(recv_str,delimeter);
        recv{ind_i} = token;
end

%MDLNames{1} = recv{4};
%recv = recv(5:end);


for k=1:12
        MDLVals{1}{k,1}=recv{(k-1)*3+2+4};
        MDLVals{1}{k,2}=recv{(k-1)*3+1+4};
        MDLVals{1}{k,3}=str2num(recv{(k-1)*3+3+4});
end

% There are six external feedback channels
for k=1:6
	AUXVals{1}{k,1}=recv{(k-1)*3+41};
	AUXVals{1}{k,2}=recv{(k-1)*3+42};
	AUXVals{1}{k,3}=str2num(recv{(k-1)*3+43});
end

% Reformat data -------------------------------------------------------------------------------------------------------
for k=1:12
    switch MDLVals{1}{k,1}
        case 'displacement'
            switch MDLVals{1}{k,2}
                case 'x'
                    obj.M_Disp(1) =MDLVals{1}{k,3};
                case 'y'
                    obj.M_Disp(2) =MDLVals{1}{k,3};
                case 'z'
                    obj.M_Disp(3) =MDLVals{1}{k,3};
            end
        case 'rotation'
            switch MDLVals{1}{k,2}
                case 'x'
                    obj.M_Disp(4) =MDLVals{1}{k,3};
                case 'y'
                    obj.M_Disp(5) =MDLVals{1}{k,3};
                case 'z'
                    obj.M_Disp(6) =MDLVals{1}{k,3};
            end
        case 'force'
            switch MDLVals{1}{k,2}
                case 'x'
                    obj.M_Forc(1) =MDLVals{1}{k,3};
                case 'y'
                    obj.M_Forc(2) =MDLVals{1}{k,3};
                case 'z'
                    obj.M_Forc(3) =MDLVals{1}{k,3};
            end
        case 'moment'
            switch MDLVals{1}{k,2}
                case 'x'
                    obj.M_Forc(4) =MDLVals{1}{k,3};
                case 'y'
                    obj.M_Forc(5) =MDLVals{1}{k,3};
                case 'z'
                    obj.M_Forc(6) =MDLVals{1}{k,3};
            end
    end
end

for k=1:6   
    switch AUXVals{1}{k,1}
        case 'ME_LC_1X'
		obj.M_AuxDisp_Raw(1) =AUXVals{1}{k,3};
        case 'ME_LC_1Y'
		obj.M_AuxDisp_Raw(2) =AUXVals{1}{k,3};
        case 'ME_LC_2X'
		obj.M_AuxDisp_Raw(3) =AUXVals{1}{k,3};
		case 'ME_LC_2Y'
		obj.M_AuxDisp_Raw(4) =AUXVals{1}{k,3};
		case 'ME_SP_Left'
		obj.M_AuxDisp_Raw(5) =AUXVals{1}{k,3};
        case 'ME_SP_Right'
		obj.M_AuxDisp_Raw(6) =AUXVals{1}{k,3};
    end
end 
% For GUI update. This indicate measured data
obj.curState = 3;
