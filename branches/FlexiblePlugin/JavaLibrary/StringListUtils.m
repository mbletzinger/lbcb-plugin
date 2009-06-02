% =====================================================================================================================
% Class which provides conversion routines between List<String> and cell
% arrays
%
% Members:
%   strUtil - a Java helper class
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef StringListUtils < handle
    properties
        strUtil = org.nees.uiuc.simcor.matlab.StringListUtils;
    end
    methods
        % converts a java string list to a cell array
        function result = sl2ca(list)
            length = list.size();
            result = cell(length,1);
            for i = 0:length
                result(i) = list.get(i);
            end
        end
        % converts a cell array to a java string list
        function result = ca2sl(cellArray)
            result = me.strUtil.a2sl(cellArray);
        end
    end
end
