function [TransID, TDisp, MDL] = Format_Rcv_Data(MDL, recv_str)

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
recv = {};



delimeter = sprintf(' \t');
while length(recv_str)>0
    ind_i = ind_i+1;
    [token, recv_str] = strtok(recv_str,delimeter);
    recv{ind_i} = token;
end

TransID = recv{2};
recv = recv(3:end);		% remove transaction ID and propose command

MDL.IN_DOF = [0 0 0 0 0 0]';
TDisp = zeros(6,1);
for i=1:length(recv)
	if(strncmp(recv{i},'MDL',3))
		% NodeNum = str2num(recv{i}(end-1:end)); 	
		% NodeNum = 1;					% ignore node number
	elseif (strcmp(recv{i},'x'))
		comp1 = 1;
	elseif (strcmp(recv{i},'y'))
		comp1 = 2;
	elseif (strcmp(recv{i},'z'))
		comp1 = 3;
	elseif (strcmp(recv{i},'displacement'))
		comp2 = 1;
	elseif (strcmp(recv{i},'rotation'))
		comp2 = 2;
	else
		MDL.IN_DOF(comp1+(comp2-1)*3) = 1;
		TDisp     (comp1+(comp2-1)*3) = str2num(recv{i});
	end
end
