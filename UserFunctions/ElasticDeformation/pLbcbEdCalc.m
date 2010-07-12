function pLbcbEdCalc(me, curLbcbCP,prevLbcbCP)
me.loadConfig();
lbcbR = curLbcbCP.response;
% offsets=[0.218 -0.260 -0.246]';
% startPos=[-0.1451 -0.0729 0.07398 0.000517 0.00825 0.000979]';
% startPos=[-0.202745 -0.0617 0.06319 -0.0002146 0.010765 0.0018288]'; % SL 06-05-10
% startPos=[-0.04981 -0.31464 0.14494 -0.000912 -0.02346 -0.003395]';
% startPos=[-0.0913 -0.2439 0.00804 0.01115 -0.005277 -0.006937]'; %Bora
% startPos=[0.37824 -0.360187 0.110031 -0.0027765 -0.0158647 0.00819773]'; % SLL Old Alu Col 070710
% startPos=[0.07165 -0.33009 0.164277 -0.0014379 -0.015128 -0.0052758]'; % SLL Old Alu Col 070910
% startPos=[0.162529 -0.362854 0.171278 0 -0.0193131 -0.00264615]'; % SLL Old Alu Col 070910 wo K
% startPos=[0.160478 -0.366679 0.170903 -0.000177649 -0.0215802 -0.00296793]'; % SLL Old Alu Col 070910 wo K & G
startPos=[-0.096414 0 0.176143 -0.00230184 0.0207437 0]'; % SLL Old Alu Col 071010 wo K 

% v0 = [1 0 2.75]'; %Bora
v0 = [1.5 0 0.75]'; % SLL Old Alu Col
% v0 = [0 0 0]';
activeDOFs = me.activeDofs;
% me.base=me.base-offsets*ones(1,length(activeDOFs));

% me.log.debug(dbstack,sprintf('ED Step: %s',curLbcbCP.toString()));

Extensions = curLbcbCP.externalSensors; % was lengths


maxnumiter=500;

% Input checker for first step
if isempty(prevLbcbCP)
    % firstStep is nested function found below for getting first SP disps
%     [prevLengths, actualLengths, prevDisplacement] = firstStep(me,v0,startPos);
    actualLengths=dof2act(startPos,v0,me.plat,me.base);
    prevLengths=actualLengths;
    prevDisplacement=startPos-startPos;
    me.initialExtensions=Extensions;
    me.initialLengths=actualLengths;
else
%     prevLengths = me.currentLengths;        % was lengths0
    prevExtensions = prevLbcbCP.externalSensors;   % was lengths0
    prevDisplacement = prevLbcbCP.response.disp; % was deltas0
    prevLengths = me.initialLengths-me.initialExtensions+prevExtensions;
    actualLengths = me.initialLengths-me.initialExtensions+Extensions;        
end
lbcbR.ed.force = lbcbR.lbcb.force;

% temp fix
lbcbR.ed.disp = lbcbR.lbcb.disp;

%  Ken's work goes here


%% Calculating displacement Jacobian for current position
% Setting delta(i) to last known delta(i) for disp-controlled DOFs
delta = [0 0 0 0 0 0]';
for i = 1:length(activeDOFs)
    delta(activeDOFs(i)) = startPos(activeDOFs(i))+prevDisplacement(activeDOFs(i));
end

% me.log.debug(dbstack,sprintf('deltas [%s]',dumpVector(delta)));
% Looping through disp-controlled DOFs to populate columns of disp Jacobian
for n = 1:length(activeDOFs)
    
    del = delta;    % Setting temporary global delta
    
    % Updating temporary global delta to include pert in current DOF
    del(activeDOFs(n)) = del(activeDOFs(n)) + me.perturbations(n);
    
    pertlength = dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
%     me.log.debug(dbstack,sprintf('pertlength [%s]',dumpVector(pertlength)));
    dldDOF = (pertlength - prevLengths)/me.perturbations(n);% SP length change/pert size
%     me.log.debug(dbstack,sprintf('dldDOF [%s]',dumpVector(dldDOF)));
    Jacobian(:,n) = dldDOF';   % Populating Jacobian column for current DOF
end

%% First estimation of position from external sensor lengths
% Estimating change in Cartesian DOFs based on change in SP lengths
for jb = 1:length(Jacobian(1,:))
        me.log.debug(dbstack,sprintf('J%d [%s]',jb,dumpVector(Jacobian(jb,:))));
end
% me.log.debug(dbstack,sprintf('actualLengths [%s]',dumpVector(actualLengths)));
% me.log.debug(dbstack,sprintf('prevLengths [%s]',dumpVector(prevLengths)));
deltaest = (Jacobian\(actualLengths - prevLengths)')';

% Defining Cartesian displacements: estimated change + previous disp
delta = [0 0 0 0 0 0]';
for d = 1:length(activeDOFs)
    delta(activeDOFs(d)) = deltaest(d) + prevDisplacement(activeDOFs(d)) + startPos(activeDOFs(d));
end

% Calculating SP lengths based on first delta approximation
lengthscalc = dof2act(delta,v0,me.plat,me.base);

% Calculating discrepancy between actual and expected SP lengths from delta
errors = actualLengths - lengthscalc;

%% Checking first estimation's accuracy and iterating as needed
% Doing a second iteration using lengthscalc as "starting" point
n = 0;
pass = 0;
if sum(abs(errors)<me.potTol) == length(activeDOFs)
    pass = 1;
end

counter=1;
while pass == 0 && counter<maxnumiter;
    deltaest = (Jacobian\(actualLengths - lengthscalc)')' + deltaest;
    
    for d = 1:length(activeDOFs)
        delta(activeDOFs(d)) = deltaest(d) + prevDisplacement(activeDOFs(d)) + startPos(activeDOFs(d));
    end
    
    lengthscalc = dof2act(delta,v0,me.plat,me.base);
    errors = actualLengths - lengthscalc;
    n = n + 1;
    
    if sum(abs(errors)<me.potTol) == length(activeDOFs)
        pass = 1;
    end
    
%     %% Loop for updating jacobian every iteration
%     for n = 1:length(activeDOFs)
%         
%         del = delta;    % Setting temporary global delta
%         
%         % Updating temporary global delta to include pert in current DOF
%         del(activeDOFs(n)) = del(activeDOFs(n)) + me.perturbations(n);
%         
%         pertlength = dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
%         %     me.log.debug(dbstack,sprintf('pertlength [%s]',dumpVector(pertlength)));
%         dldDOF = (pertlength - actualLengths)/me.perturbations(n);% SP length change/pert size
%         %     me.log.debug(dbstack,sprintf('dldDOF [%s]',dumpVector(dldDOF)));
%         Jacobian(:,n) = dldDOF';   % Populating Jacobian column for current DOF
%     end
    counter=counter+1;
end
if counter==maxnumiter;
    error('Elastic deformations did not converge');
end

for d = 1:length(activeDOFs)
    deltaest(d) = delta(activeDOFs(d));
end

%% Store the resulting cartesian displacement
curLbcbCP.response.ed.disp = zeros(6,1);
for i = 1:length(activeDOFs)
    curLbcbCP.response.ed.disp(activeDOFs(i)) = deltaest(i) - startPos(activeDOFs(i));
end

% me.log.debug(dbstack,sprintf('ed control point: %s',curLbcbCP.toString()))


%% Nested function to calculate Cartesian displacement at startup:
    function [prevLengths, actualLengths, prevDisplacement] = firstStep(me,v0,startPos)
       
       activeDOFs = me.activeDofs;
     
       actualLengths = dof2act(startPos,v0,me.plat,me.base);
       prevLengths = actualLengths;
       prevDisplacement = zeros(6,1);       
%        activeDOFs = [1 3 5];
%        v0 = [0 0 0]';
       
       %% Calculating displacement Jacobian for unknown startup position
       % Setting delta(i) to zeros since nothing is known at startup
%        delta = [0 0 0 0 0 0]';   
       delta=startPos;
%        me.log.debug(dbstack,sprintf('activeDOFS [%s]',dumpVector(activeDOFs)));
%        me.log.debug(dbstack,sprintf('perturbations [%s]',dumpVector(me.perturbations)));
%        me.log.debug(dbstack,sprintf('actualLengths [%s]',dumpVector(actualLengths)));
%        me.log.debug(dbstack,sprintf('prevLengths [%s]',dumpVector(prevLengths)));
       
       % Looping through disp-controlled DOFs to populate columns of disp Jacobian
       zerolength = dof2act(delta,v0,me.plat,me.base); % Calc SP_lengths at Zero Position
       
       for i = 1:length(activeDOFs)
           
           del = delta;    % Setting temporary global delta
           
           % Updating temporary global delta to include pert in current DOF
           del(activeDOFs(i)) = del(activeDOFs(i)) + me.perturbations(i);
           
           pertlength = dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
           dldDOF = (pertlength - zerolength)/me.perturbations(i);% SP length change/pert size
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
%            deltaest = Jacobian;
           deltaest = zeros(size(deltaLs));
       end
       
       % Defining Cartesian displacements: estimated change + previous disp
       delta = [0 0 0 0 0 0]';
       for j = 1:length(activeDOFs)
           delta(activeDOFs(j)) = deltaest(j) + prevDisplacement(activeDOFs(j));
       end
       
       % Calculating SP lengths based on first delta approximation
       lengthscalc = dof2act(delta,v0,me.plat,me.base);
       
       % Calculating discrepancy between actual and expected SP lengths from delta
       errors = actualLengths - lengthscalc;
       
       %% Checking first estimation's accuracy and iterating as needed
       % Doing a second iteration using lengthscalc as "starting" point
       n = 0;
       pass = 0;
       if sum(abs(errors)<me.potTol) == length(activeDOFs)
           pass = 1;
       end
       
       counter=1;
       while pass == 0 && counter<maxnumiter;
           deltaest = (Jacobian\(actualLengths - lengthscalc)')' + deltaest;
           
           for j = 1:length(activeDOFs)
               delta(activeDOFs(j)) = deltaest(j) + prevDisplacement(activeDOFs(j));
           end
           
           lengthscalc = dof2act(delta,v0,me.plat,me.base);
           errors = actualLengths - lengthscalc;
           n = n + 1;
           
           if sum(abs(errors)<me.potTol) == length(activeDOFs)
               pass = 1;
           end
           
%            %% Loop for updating Jacobian every iteration
%            for n = 1:length(activeDOFs)
%                
%                del = delta;    % Setting temporary global delta
%                
%                % Updating temporary global delta to include pert in current DOF
%                del(activeDOFs(n)) = del(activeDOFs(n)) + me.perturbations(n);
%                
%                pertlength = dof2act(del,v0,me.plat,me.base); % Calc for expected SP lengths
%                %     me.log.debug(dbstack,sprintf('pertlength [%s]',dumpVector(pertlength)));
%                dldDOF = (pertlength - actualLengths)/me.perturbations(n);% SP length change/pert size
%                %     me.log.debug(dbstack,sprintf('dldDOF [%s]',dumpVector(dldDOF)));
%                Jacobian(:,n) = dldDOF';   % Populating Jacobian column for current DOF
%            end
           counter=counter+1;
       end
       if counter==maxnumiter;
           error('Elastic deformations did not converge');
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
