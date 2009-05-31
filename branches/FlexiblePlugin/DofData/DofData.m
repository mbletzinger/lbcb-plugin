% =====================================================================================================================
% Class containing degrees-of-freedom data.
%
% Members:
%   disp - Translation and rotation DOFs Dx,Dy,Dz, Rx, Ry, Rz.
%   force - Force and Moment DOFs Fx, Fy, Fz, Mx, My, Mz.
%
% $LastChangedDate:   $ 
% $Author:    $
% =====================================================================================================================
classdef DofData < handle
    properties
        disp = zeros(6,1);   
        force = zeros(6,1);    
    end
end