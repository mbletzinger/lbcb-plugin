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
        Fz1tar = 0;
        Fz2tar = 0;
        log = Logger('DerivedDof');
        cdp;
    end
    methods
        function me = DerivedDof(cdp)
            me.cdp = cdp;
        end
        calculate(me,cstep)
        adjustTarget(me,step)
        loadConfig(me)
    end
end