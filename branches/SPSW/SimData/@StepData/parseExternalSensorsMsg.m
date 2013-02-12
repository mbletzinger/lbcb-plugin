function values = parseExternalSensorsMsg(me,names,msg)

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;
numChannels = sum(cellfun(@ischar,names));
recv = cell(numChannels * 3,1);
values = zeros(numChannels,1);
recv = regexp(msg,'\t','split');
MDLVals = cell(numChannels,3);
sz = length(recv);
if sz ~= numChannels*3
    me.log.error(dbstack,'External Sensors are misconfigured');
    nameStr = '';
    for n = 1:length(names)
        nameStr = sprintf('%s"%s",',nameStr,names{n});
    end
    me.log.debug(dbstack, sprintf('Specified Channels [%s]',nameStr));
    me.log.debug(dbstack, sprintf('OM Msg [%s]',msg));
    return;
end
for k=1:numChannels
    MDLVals{k,1}=recv{(k-1)*3 + 1};
    MDLVals{k,2}=recv{(k-1)*3+2};
    MDLVals{k,3}=str2double(recv{(k-1)*3+3});
end


%SJKIM Oct24-2007
% For Test
for k=1:numChannels
    found = false;
    for j=1:numChannels
        if strcmp(names{j},MDLVals{k,1})
            values(j) = MDLVals{k,3};
            found = true;
            break;
        end
    end
    if found == false
        me.log.error(dbstack, sprintf('No OM Sensor for "%s" specified',MDLVals{k,1}));
    end
end
