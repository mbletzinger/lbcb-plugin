% =====================================================================================================================
% Class containing degrees-of-freedom data.
%
% Members:
%   disp - Translation and rotation DOFs Dx,Dy,Dz, Rx, Ry, Rz.
%   force - Force and Moment DOFs Fx, Fy, Fz, Mx, My, Mz.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef DofData < handle
    properties
        disp = zeros(6,1);
        force = zeros(6,1);
    end
    methods
        function str = toString(me)
            labels = {'dx' 'dy' 'dz' 'rx' 'ry' 'rz'};
            str = '';
            for v = 1:length(me.disp)
                str = sprintf('%s/%s=%f',str,labels{v},me.disp(v));
            end
            labels = {'fx' 'fy' 'fz' 'mx' 'my' 'mz'};
            for v = 1:length(me.force)
                str = sprintf('%s/%s=%f',str,labels{v},me.force(v));
            end
        end
    end
end