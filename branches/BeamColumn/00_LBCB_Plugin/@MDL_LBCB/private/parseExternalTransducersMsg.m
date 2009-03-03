function values = parseExternalTransducersMsg(me,msg)
AUXVals  = cell(1);


% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
numChannels = length(me.ExtTrans.Config.AllNumSensors);
recv = cell(numChannels * 3,1);
values = zeros(numChannels,1);
delimiter = sprintf(' \t');
while length(msg)>0
        ind_i = ind_i+1;
        [token, msg] = strtok(msg,delimiter);
        recv{ind_i} = token;
end


for k=1:numChannels
        MDLVals{1}{k,1}=recv{(k-1)*3+2+4};
        MDLVals{1}{k,2}=recv{(k-1)*3+1+4};
        MDLVals{1}{k,3}=str2double(recv{(k-1)*3+3+4});
end


%SJKIM Oct24-2007
% For Test
for k=1:numChannels
    for j=1:numChannels
        if strcmp(me.ExtTrans.Config.AllNames{j},MDLVals{1}{k,2})
            values(j) = MDLVals{1}{k,3};
            break;
        end
    end
end 
