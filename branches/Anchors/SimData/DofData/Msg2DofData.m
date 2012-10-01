% =====================================================================================================================
% Class Which parse LBCB get-control-point messages
%
% Members:
%   delimiter - character which separates message fields.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef Msg2DofData < handle
    properties
    end
    methods
        % Extracts the control point suffix from the control point address
        function cps = parseCps(me,mdl)
            cps = sscanf(mdl(:),':%s');
        end
        % Parses the data portion of a control point message
        function data = parse(me,msg)
            data = {Target()};
            tgt =1;
            tokens = regexp(char(msg),'\t','split');
            cellA = me.tokensSort(tokens);
            [nr dum]  = size(cellA);
            for r = 1:nr
                subCell = cellA(r,:);
                [index isForce value] = me.findIndex(subCell);
                if(index == 0)
                    tgt = tgt + 1;
                    data{tgt} = Target();
                    continue;
                end
                if isForce
                    data{tgt}.setForceDof(index,value);
                else
                    data{tgt}.setDispDof(index,value);
                end
            end
        end
        % Sorts the token array into a cell array:
        % Column 1 - Is either the cartesian axis or the control point
        % address
        %
        % Column 2 - Is the DOF type
        % Column 3 - Is the value at the DOF.
        
        function cellA = tokensSort(me,tokens)
            row = 1;
            lgth = length(tokens);
            cellLgth = lgth / 3;  % this is a low ball guess
            cellLgth = cellLgth + mod(lgth,3);
            cellA = cell(int16(cellLgth),3);
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
        %  Calculates the index of a data entry in the token array
        function [index isForce value] = findIndex(me,row)
            index = 0;
            isForce = 0;
            value = row{3};
            if isempty(row{1})
                return;
            end
            
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