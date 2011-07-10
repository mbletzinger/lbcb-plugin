  % =====================================================================================================================
% Class which calculates the position of an LBCB platform based on external
% sensors
%
% Members:
%   base - position of the sensor base bin in LBCB coordinates
%   plat - position of the sensor platform bin in LBCB coordinates
%   perturbations - The amount of displacement applied to a difference
%   calculation.
%   jacobian - matrix which transforms calculated sensor length differences
%   based on the perturbation applied.
%
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef ElasticDeformation < CorrectionVariables
    properties
        %==
        % properties of these two variables
        % size of each one: 3 x (# of sensors)
        fixedLocations = [];
        pinLocations = [];
        
        % 2 x (# of sensors)
        limits = [];
        errorTolerance = [];
       
        transPert
        rotPert
        
        
        %==
        log = Logger('ElasticDeformation');
        isLbcb1;
        %==
        % properties of these two variables 
        % they are initial and current readings of external sensors
        % displacements = curReadings - initialReadings;
        % size: (# of sensors) x 1
	    initialReadings = [];       
        curReadings = []; 
        %==
        % optimization setting for "optimset"
        % optSetting.maxfunevals : max. # of iterations for minimizing
        %                          the objective function (default = 1000)
        % optSetting.maxiter : max. # of iterations for optimizing the
        %                      control point (default = 100)
        % optSetting.tolfun : tolerance of the objective function
        %                     (default = 1e-8)
        % optSetting.tolx: tolerance of the control point
        %                  (default = 1e-12)
        % optSetting.jacob: switch for jacobian matrix, 'on' or 'off'
        %                   (default = 'on')
	    optSetting;
        %==
        % a bond for needsCorrection
        % size: 2 x 1, in which first one is for translations and the
        % second one is for rotations
        within = [];
    end
    methods
        function me = ElasticDeformation(cdp,isLbcb1)
            me = me@CorrectionVariables(cdp);
            me.isLbcb1 = isLbcb1;
        end
        nextCommand = adjustTarget(me,correctionTarget,curResponse,curCommand)
        prelimAdjust(me,prevCorrection,curCommand)
        curResponse = calculate(me, prevResponse, sensorReadings, initialReadings)
        loadConfig(me)
        yes = needsCorrection(me,curResponse, correctionTarget)
	
    end
end