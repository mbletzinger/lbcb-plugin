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
classdef ElasticDeformationCalculations < handle
    properties
        base = [];
        plat = [];
        previousLengths = [];
        currentLengths = [];
        jacobian = [];
        calcPlatCtr = [];
        MeasPltCtr = [];
        perturbations = [];
        potTol = [];
    end
    methods
        function me = ElasticDeformationCalculations(cfg,isLbcb1)
            config = ConfigExternalSensors(cfg);
            if isLbcb1
                me.base = config.Lbcb1.Base;
                me.plat = config.Lbcb1.Plat;
%                 me.previousLengths = some math from base and plat
%                 me.potTol = configs.Lbcb1.potTol;

            else
                me.base = config.Lbcb2.Base;
                me.plat = config.Lbcb2.Plat;
%                 me.previousLengths = some math from base and plat
%                 me.potTol = configs.Lbcb2.potTol;
            end
            % Change to vector config.Params.pert
            me.perturbations = [config.Params.pertDx, config.Params.pertDz, config.Params.pertRy ];
        end
        
        % calculate LBCB position based on external sensor readings.
        function calculate(me, curLbcbCP,prevLbcbCP)
            lbcbR = lbcbCP.response;
            actualLengths = lbcbCP.externalSensors; % was lengths
            prevLengths = me.currentLengths;        % was lengths0
            prevDisplacement = prevLbcbCP.response.disp; % was deltas0
            lbcbR.ed.force = lbcbR.lbcb.force;

            % temp fix
            lbcbR.ed.disp = lbcbR.lbcb.disp;
            
            %  Ken's work goes here
            activeDOFs = [1 3 5];
            v0 = [0 0 0]';
            
            %% Calculating displacement Jacobian for current position
            % Setting delta(i) to last known delta(i) for disp-controlled DOFs
            delta = [0 0 0 0 0 0]';
            for i = 1:length(activeDOFs)
                delta(activeDOFs(i)) = prevDisplacement(activeDOFs(i));
            end

            % Looping through disp-controlled DOFs to populate columns of disp Jacobian
            for i = 1:length(activeDOFs)
    
                del = delta;    % Setting temporary global delta
    
                % Updating temporary global delta to include pert in current DOF
                del(activeDOFs(i)) = del(activeDOFs(i)) + me.perturbations(i);
    
                pertlength = dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
                dldDOF = (pertlength - actualLengths')/me.perturbations(i);% SP length change/pert size
                Jacobian(:,i) = dldDOF';   % Populating Jacobian column for current DOF
            end
            
            %% First estimation of position from external sensor lengths
            % Estimating change in Cartesian DOFs based on change in SP lengths
            deltaest = Jacobian\(actualLengths - prevLengths);

            % Defining Cartesian displacements: estimated change + previous disp
            delta = [0 0 0 0 0 0]';
            for j = 1:length(activeDOFs)
                delta(activeDOFs(j)) = deltaest(j) + prevDisplacement(j);
            end

            % Calculating SP lengths based on first delta approximation
            lengthscalc = dof2act(delta,v0,me.plat,me.base);

            % Calculating discrepancy between actual and expected SP lengths from delta
            errors = actualLengths - lengthscalc'; 
                        
            %% Checking first estimation's accuracy and iterating as needed
            % Doing a second iteration using lengthscalc as "starting" point
            n = 0;
            pass = 0;
            if sum(abs(errors)<me.potTol) == length(activeDOFs)
                pass = 1;
            end

            while pass == 0
                deltaest = Jacobian\(actualLengths - lengthscalc') + deltaest;

                for j = 1:length(activeDOFs)
                    delta(activeDOFs(j)) = deltaest(j) + prevDisplacement(j);
                end
                
                lengthscalc = dof2act(delta,v0,me.plat,me.base);
                errors = actualLengths - lengthscalc';
                n = n + 1;

                if sum(abs(errors)<me.potTol) == length(activeDOFs)
                    pass = 1;
                end
            end

            for j = 1:length(activeDOFs)
                deltaest(j) = delta(activeDOFs(j));
            end
            
            %% Store the resulting cartesian displacement
            curLbcbCP.response.ed.disp = zeros(6,1);
            for i = 1:length(activeDOFs)
                curLbcbCP.response.ed.disp(activeDOFs(i)) = deltaest(i);
            end
        end
    end
end