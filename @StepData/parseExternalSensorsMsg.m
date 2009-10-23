function values = parseExternalSensorsMsg(me,names,msg)

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
numChannels = sum(cellfun(@ischar,names));
recv = cell(numChannels * 3,1);
values = zeros(numChannels,1);
recv = regexp(char(msg),'\t','split');
MDLVals = cell(numChannels,3);
for k=1:numChannels
        MDLVals{k,1}=recv{(k-1)*3 + 1};
        MDLVals{k,2}=recv{(k-1)*3+2};
        MDLVals{k,3}=str2double(recv{(k-1)*3+3});
end


%SJKIM Oct24-2007
% For Test
for k=1:numChannels
    for j=1:numChannels
        if strcmp(names{j},MDLVals{k,1})
            values(j) = MDLVals{k,3};
            break;
        end
    end
end 
