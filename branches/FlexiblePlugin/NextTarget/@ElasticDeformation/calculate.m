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
    
    pertlength = me.dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
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
lengthscalc = me.dof2act(delta,v0,me.plat,me.base);

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
    
    lengthscalc = me.dof2act(delta,v0,me.plat,me.base);
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
