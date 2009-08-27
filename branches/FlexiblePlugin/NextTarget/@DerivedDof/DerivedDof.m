% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef DerivedDof < handle
    properties
        dxlbcb1 = 5.5;      % Distance from wall center to right pier center
        dxlbcb2 = -5.5;     % Distance from wall center to left pier center
        
        % Varibles to read in from interface; may change during test:
        % % kfactor
        % % Fztarget
        kfactor = -25;  % temporary hard-coded values
        Fztarget = 250; % temporary hard-coded values
    end
    methods
        calculate(me,cstep)
        nstep = newStep(me,cstep)
    end
end