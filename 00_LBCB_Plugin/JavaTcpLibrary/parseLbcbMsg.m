function [disp forces] = parseLbcbMsg(msg)
MDLVals  = cell(1);

% Deliminate received data and save in variables ------------------------------------------------------------------
ind_i = 0;

recv = cell(36,1);
disp = zeros(6,1);
forces = zeros(6,1);

delimiter = sprintf(' \t');
while length(msg)>0
        ind_i = ind_i+1;
        [token, msg] = strtok(msg,delimiter);
        recv{ind_i} = token;
end

%MDLNames{1} = recv{4};
%recv = recv(5:end);

for k=1:12
        MDLVals{1}{k,1}=recv{(k-1)*3+2+4};
        MDLVals{1}{k,2}=recv{(k-1)*3+1+4};
        MDLVals{1}{k,3}=str2double(recv{(k-1)*3+3+4});
end

% Reformat data -------------------------------------------------------------------------------------------------------
for k=1:12
    switch MDLVals{1}{k,1}
        case 'displacement'
            switch MDLVals{1}{k,2}
                case 'x'
                    disp(1) =MDLVals{1}{k,3};
                case 'y'
                    disp(2) =MDLVals{1}{k,3};
                case 'z'
                    disp(3) =MDLVals{1}{k,3};
            end
        case 'rotation'
            switch MDLVals{1}{k,2}
                case 'x'
                    disp(4) =MDLVals{1}{k,3};
                case 'y'
                    disp(5) =MDLVals{1}{k,3};
                case 'z'
                    disp(6) =MDLVals{1}{k,3};
            end
        case 'force'
            switch MDLVals{1}{k,2}
                case 'x'
                    forces(1) =MDLVals{1}{k,3};
                case 'y'
                    forces(2) =MDLVals{1}{k,3};
                case 'z'
                    forces(3) =MDLVals{1}{k,3};
            end
        case 'moment'
            switch MDLVals{1}{k,2}
                case 'x'
                    forces(4) =MDLVals{1}{k,3};
                case 'y'
                    forces(5) =MDLVals{1}{k,3};
                case 'z'
                    forces(6) =MDLVals{1}{k,3};
            end
    end
end
