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
        labels = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz',...
            'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz'};
    end
    methods
        function str = toString(me)
            str = '';
            for v = 1:length(me.disp)
                str = sprintf('%s/%s=%f',str,me.labels{v},me.disp(v));
            end
            for v = 1:length(me.force)
                str = sprintf('%s/%s=%f',str,me.labels{v + 6},me.force(v));
            end
        end
        function l = label(me,dof,isLbcb1)
            idx = (isLbcb1 == false) + 1;
            l = sprintf('LBCB%d %s', idx,me.labels{dof});
        end
    end
end