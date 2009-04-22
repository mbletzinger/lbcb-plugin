function values = parseExternalTransducersMsg(names,msg)
AUXVals  = cell(1);


% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
numChannels = length(names);;
recv = cell(numChannels * 3,1);
values = zeros(numChannels,1);
delimiter = sprintf(' \t');
while iempty(msg) ==false
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
        if strcmp(names{j},MDLVals{1}{k,2})
            values(j) = MDLVals{1}{k,3};
            break;
        end
    end
end 
