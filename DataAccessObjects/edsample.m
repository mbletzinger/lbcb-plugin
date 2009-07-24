close all; clear all

%% Defining configuration parameters
activeDOFs = [1 3 5];   % Specify which Degrees of Freedom are being
                        %   controlled: 1-x, 2-y, 3-z, 4-rx, 5-ry, 6-rz

DOF_tol = [0.001 0.001 0.0000762];  % Tolerances for each active DOF
                        
v0 = [0 0 0]';          % Coordinates for specimen Control Point

p0 = [0     0   0       % String pot end points on specimen
      -27   10  0       %   [x1 y1 z1;
      27    10  0]';    %    x2 y2 z2;...]'

q0 = [-80   0   0       % String point anchor points (not on specimen)
      -27   10  156     %   [x1 y1 z1;
      27    10  156]';  %    x2 y2 z2;...]'

deltas0 = [0 0 0 0 0 0]';   % Initial starting position
sp_tol = 0.00001;           % String pot tolerance parameter


weight = 0.5;   %Predictive ED compensation weigthing factor; between 0 & 1
EDlosses = [0.75  1  0.5  1  0.95  1]'; % LBCB motion multiplier to account for
                                        %   elastic deformation losses.

% Loop used to assign individual string pot tolerances and "tweaks" to be
%   used for getting linearized displacement Jacobian
for i = 1:length(activeDOFs)
    sp_tol(i) = sp_tol(1);
    if activeDOFs(i) <= 3
        tweak(i) = 0.01;
    elseif activeDOFs(i) <= 6
        tweak(i) = 0.00017453;
    else
        beep
        disp('ERROR: Invalid DOF assignament.')
    end
end

lengths0 = dof2act(deltas0,v0,p0,q0); % Initial string pot lengths
lengths = lengths0;     % Setting current SP lengths to SP initial lengths

% d_targets= [0:0.1:2; zeros(1,21); 0:0.05:1; zeros(1,21); 0:7.62e-3:.1524; zeros(1,21)]';
% d_targets= [d_targets; flipud(d_targets)];
d_targets = [0        0     0       0   0           0
             0        0     0.25    0   0           0
             0.1      0     0.15    0   7.62e-3     0
             0.1      0     0.15    0   7.62e-3     0
             0.5      0     0.05    0   3.5e-2      0
             0        0     0       0   0           0
             -10      0     -1      0   -7.62e-2    0
             10       0     1       0   7.62e-2     0
             0        0     0       0   0           0];
       
d_measured = deltas0;
d_current = deltas0;
d_command = [0 0 0 0 0 0]';
dfactors = [1 1 1 1 1 1]'; % ED compensation factors; all 1s at beginning

%% Looping through displacement targets
for i = 1:size(d_targets,1)
    
    pass = 0; % Flag to remain inside elastic deformation loop
    count = 0;% Count of displacement commands to reach targets
    
    while pass == 0     % While measured displacement != target disp.
        
        count = count + 1;      % Counts number of displacement iterations
        lengths0 = lengths;     % Sets initial lengths to previous lengths
        d_measured_old = d_measured;    % Sets old Cartesian measurements
        d_command_old = d_command;      % Sets old Cartesian commands
        
        d_command = EDcorrection2(d_targets(i,:)',d_measured,d_current,...
            dfactors);  % Calculating next LBCB command
        
        % Modifying command in order to simulate ED losses
        d_mod = (d_command - d_current).*EDlosses + d_measured;

        lengths = dof2act(d_mod,v0,p0,q0); % Calcing lengths for mod cmd
        d_measured = getDeltas3(d_mod,lengths0,lengths,sp_tol,v0,p0,...
            q0,activeDOFs,tweak); % Back-calcing Cart. disp. from sp lnghts
        
        % Updating ED compensation factors based on command-v-measured disp
        dfactors = getdfactors(dfactors, d_command_old, d_command,...
            d_measured_old, d_measured, weight, activeDOFs);
        DOF_err = d_targets(i,:)' - d_measured; %Calc: target-actual disp
        d_current = d_command;  % d_current: current LBCB command
        
        % Looping thru active DOFs; checking if actual disp is within tol
        checker = zeros(length(activeDOFs),1);
        for j = 1:length(activeDOFs)
            if abs(DOF_err(activeDOFs(j))) < DOF_tol(j)
                checker(j) = 1;
            end
        end
        
        % If all active DOFs are within their tolerances...
        if sum(checker) == length(activeDOFs)
            pass = 1;   % Flag to exit while loop for current targets
            [asdf(:,i),errors(:,i),n(i)] = getDeltas3(d_mod,lengths0,...
                lengths,sp_tol,v0,p0,q0,activeDOFs,tweak);
            iter(i) = count;
        end
        
    end
    
    % Printing step summary to screen
    fprintf('Load Step #%i\n',i)
    fprintf('Target Displacements:\n')
    fprintf('dx: %f; dy: %f; dz: %f; rx: %f; ry: %f; rz: %f\n',...
        d_targets(i,1),d_targets(i,2),d_targets(i,3),d_targets(i,4),...
        d_targets(i,5),d_targets(i,6))
    fprintf('Measured Displacements:\n')
    fprintf('dx: %f; dy: %f; dz: %f; rx: %f; ry: %f; rz: %f\n',...
        asdf(1,i),asdf(2,i),asdf(3,i),asdf(4,i),asdf(5,i),asdf(6,i))
    fprintf('Number of displacement steps: %i\n\n',count)
    
end
% 
% for i = 1:size(d_targets,1)
%     
%     fprintf('Load Step #%i\n',i)
%     fprintf('Target Displacements:\n')
%     fprintf('dx: %f; dy: %f; dz: %f; rx: %f; ry: %f; rz: %f\n',...
%         d_targets(i,1),d_targets(i,2),d_targets(i,3),d_targets(i,4),...
%         d_targets(i,5),d_targets(i,6))
%     fprintf('Measured Displacements:\n')
%     fprintf('dx: %f; dy: %f; dz: %f; rx: %f; ry: %f; rz: %f\n\n',...
%         asdf(1,i),asdf(2,i),asdf(3,i),asdf(4,i),asdf(5,i),asdf(6,i))
%     
%     
% end
% 
%     
%     