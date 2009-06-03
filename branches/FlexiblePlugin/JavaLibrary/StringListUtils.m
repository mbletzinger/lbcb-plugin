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
        function result = sl2ca(me,list)
            length = list.size();
            result = cell(length,1);
            for i = 0:length - 1
                result{i + 1} = list.get(i);
            end
        end
        % converts a cell array to a java string list
        function result = ca2sl(me,cellArray)
            lgth = length(cellArray);
            stringA= javaArray('java.lang.String',lgth);
            for i=1:lgth
                if isempty(cellArray{i}) == 0
                    stringA(i) = java.lang.String(cellArray{i});
                end
            end
            result = me.strUtil.a2sl(stringA);
        end
    end
end
