classdef msg2DofData < handle
    properties
        delimiter = sprintf(' \t');
    end
    methods
        function data = parse(me,msg,mdl)
            data = {lbcbTarget()};
            data{1}.node = mdl;
            tgt =1;
            tokens = me.splitTokens(msg);
            cellA = me.tokensSort(tokens);
            [nr dum]  = size(cellA);
            for r = 1:nr
                subCell = cellA(r,:);
                [index isForce value] = me.findIndex(subCell);
                if(index == 0)
                    tgt = tgt + 1;
                    data{tgt} = lbcbTarget();
                    data{tgt}.node = cellA{r,1};
                    continue;
                end
                if isForce
                    data{tgt}.target.force(index) = value;
                    data{tgt}.forceDofs(index) = 1;
                else
                    data{tgt}.target.disp(index) = value;
                    data{tgt}.dispDofs(index) = 1;
                end
            end
        end
        function cellA = tokensSort(me,tokens)
            row = 1;
            lgth = length(tokens);
            cellLgth = lgth / 3;  % this is a low ball guess
            cellLgth = cellLgth + mod(lgth,3);
            cellA = cell(cellLgth,3);
            for t = 1:lgth
                switch tokens{t}
                    case {'x','y','z'}
                        cellA(row,1) = tokens(t);
                    case {'displacement','rotation','force','moment'}
                        cellA(row,2) = tokens(t);
                    otherwise
                        if  isempty(tokens{t})
                            continue;
                        end
                        num = str2double(tokens{t});
                        if isnan(num)
                            cellA(row,1) = tokens(t); % assume this is a MDL address
                        else
                            cellA{row,3} = num;
                        end
                        row = row+1;
                end
            end
        end
        function tokens =  splitTokens(me,msg)
            i = 0;
            while isempty(msg) == 0
                i = i+1;
                [token, msg] = strtok(msg,me.delimiter);
                tokens{i} = token;
            end
        end
        function [index isForce value] = findIndex(me,row)
            index = 0;
            isForce = 0;
            value = row{3};
            
            switch row{1}
                case 'x'
                    index = 1;
                case 'y'
                    index = 2;
                case 'z'
                    index = 3;
                otherwise
                    return;
            end
            switch row{2}
                case 'displacement'
                case 'rotation'
                    index = index + 3;
                case 'force'
                    isForce = 1;
                case 'moment'
                    index = index + 3;
                    isForce = 1;
            end
        end
    end
end