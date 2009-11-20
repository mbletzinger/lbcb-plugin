function coupledWallCalculate(me, curLbcbCP,prevLbcbCP)
me.loadConfig();
lbcbR = curLbcbCP.response;
actualLengths = curLbcbCP.externalSensors; % was lengths
activeDOFs = me.activeDofs;
v0 = [0 0 0]';

% Input checker for first step
if isempty(prevLbcbCP)
    % firstStep is nested function found below for getting first SP disps
    [prevLengths, prevDisplacement] = firstStep(me,actualLengths);
else
    prevLengths = me.currentLengths;        % was lengths0
    prevDisplacement = prevLbcbCP.response.disp; % was deltas0
end
lbcbR.ed.force = lbcbR.lbcb.force;

% temp fix
lbcbR.ed.disp = lbcbR.lbcb.disp;

%  Ken's work goes here


%% Calculating displacement Jacobian for current position
% Setting delta(i) to last known delta(i) for disp-controlled DOFs
delta = [0 0 0 0 0 0]';
for i = 1:length(activeDOFs)
    delta(activeDOFs(i)) = prevDisplacement(activeDOFs(i));
end

me.log.debug(dbstack,sprintf('deltas [%s]',dumpVector(delta)));
% Looping through disp-controlled DOFs to populate columns of disp Jacobian
for i = 1:length(activeDOFs)
    
    del = delta;    % Setting temporary global delta
    
    % Updating temporary global delta to include pert in current DOF
    del(activeDOFs(i)) = del(activeDOFs(i)) + me.perturbations(i);
    
    pertlength = me.dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
    me.log.debug(dbstack,sprintf('pertlength [%s]',dumpVector(pertlength)));
    dldDOF = (pertlength - actualLengths)/me.perturbations(i);% SP length change/pert size
    me.log.debug(dbstack,sprintf('dldDOF [%s]',dumpVector(dldDOF)));
    Jacobian(:,i) = dldDOF';   % Populating Jacobian column for current DOF
end

%% First estimation of position from external sensor lengths
% Estimating change in Cartesian DOFs based on change in SP lengths
for jb = 1:length(Jacobian(1,:))
        me.log.debug(dbstack,sprintf('J%d [%s]',jb,dumpVector(Jacobian(jb,:))));
end
me.log.debug(dbstack,sprintf('actualLengths [%s]',dumpVector(actualLengths)));
me.log.debug(dbstack,sprintf('prevLengths [%s]',dumpVector(prevLengths)));
deltaest = Jacobian\(actualLengths - prevLengths);

% Defining Cartesian displacements: estimated change + previous disp
delta = [0 0 0 0 0 0]';
for d = 1:length(activeDOFs)
    delta(activeDOFs(d)) = deltaest(d) + prevDisplacement(d);
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
    
    for d = 1:length(activeDOFs)
        delta(activeDOFs(d)) = deltaest(d) + prevDisplacement(d);
    end
    
    lengthscalc = me.dof2act(delta,v0,me.plat,me.base);
    errors = actualLengths - lengthscalc';
    n = n + 1;
    
    if sum(abs(errors)<me.potTol) == length(activeDOFs)
        pass = 1;
    end
end

for d = 1:length(activeDOFs)
    deltaest(d) = delta(activeDOFs(d));
end

%% Store the resulting cartesian displacement
curLbcbCP.response.ed.disp = zeros(6,1);
for i = 1:length(activeDOFs)
    curLbcbCP.response.ed.disp(activeDOFs(i)) = deltaest(i);
end




%% Nested function to calculate Cartesian displacement at startup:
    function [prevLengths, prevDisplacement] = firstStep(me,actualLengths)
       
       prevLengths = actualLengths;
       prevDisplacement = zeros(6,1);
%        activeDOFs = [1 3 5];
%        v0 = [0 0 0]';
       
       %% Calculating displacement Jacobian for unknown startup position
       % Setting delta(i) to zeros since nothing is known at startup
       delta = [0 0 0 0 0 0]';
       me.plat
       me.base
       me.log.debug(dbstack,sprintf('activeDOFS [%s]',dumpVector(activeDOFs)));
       me.log.debug(dbstack,sprintf('perturbations [%s]',dumpVector(me.perturbations)));
       me.log.debug(dbstack,sprintf('actualLengths [%s]',dumpVector(actualLengths)));
       me.log.debug(dbstack,sprintf('prevLengths [%s]',dumpVector(prevLengths)));
       % Looping through disp-controlled DOFs to populate columns of disp Jacobian
       for i = 1:length(activeDOFs)
           
           del = delta;    % Setting temporary global delta
           
           % Updating temporary global delta to include pert in current DOF
           del(activeDOFs(i)) = del(activeDOFs(i)) + me.perturbations(i);
           
           pertlength = me.dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
           dldDOF = (pertlength - actualLengths)/me.perturbations(i);% SP length change/pert size
           Jacobian(:,i) = dldDOF';   % Populating Jacobian column for current DOF
       end
       for jbb = 1:length(Jacobian(1,:))
           me.log.debug(dbstack,sprintf('J%d [%s]',jbb,dumpVector(Jacobian(jbb,:))));
       end
       
       %% First estimation of position from external sensor lengths
       % Estimating change in Cartesian DOFs based on change in SP lengths
       deltaLs = actualLengths - prevLengths;
       if all(deltaLs)
       deltaest = Jacobian\(deltaLs);
       else
           me.log.info(dbstack,'No change in length detected');
           deltaest = Jacobian;
       end
       
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
       prevDisplacement = zeros(6,1);
       for i = 1:length(activeDOFs)
           prevDisplacement(activeDOFs(i)) = deltaest(i);
       end
      
    end
    function s = dumpVector(dat)
        s = '';
        for i = 1: length(dat)
            s = sprintf('%s %f',s,dat(i));
        end
    end
end
