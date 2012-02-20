classdef TableDataManagement < handle
    properties
    end
    methods
        function [d u] = getData(me,data)
            d = 0;
            u = false;
            if isempty(data) == false
                if ischar(data)
                    nli = str2double(data);
                    if isnan(nli) == false
                        d = nli;
                        u = true;
                    end
                else
                    d = data;
                    u = true;
                end
            end
        end
    end
end