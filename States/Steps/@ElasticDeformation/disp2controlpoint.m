function cmd = disp2controlpoint(d,xpin,xfix,xcurrent,cmdlast,imode,optm,idof)
% disp2controlpoint is to calculate the position of the current control 
% point based on the local measurements from LVDTs or linear pots or the 
% free pin points
% inputs: d        - measurements from LVDTs or linear pots. This variable
%                    will be always the total difference between the 
%                    initial reading and the current reading.
%         xcurrent - current pin locations (x,y,z). It is location by
%                    number of external sensors, i.e., size(current) = [3 #
%                    of sensors]
%         xpin     - initial free-end pins' locations, which have the same
%                    definition as xcurrent
%         xfix     - fixed-end pins' locations, which have the same
%                    definition as xpin and xcurrent
%         cmdlast  - the previous commands for the control point
%         imode    - the case of imode = 1 awlays starts from the initial
%                    xpin location and considers the current measurements 
%                    only. The case of imode = 2 has the same features of 
%                    imode = 1 but it also inculdes the current pin 
%                    locations in the algorithm (not developed). 
%                    The case of imode = 3 always starts from 
%                    the previous step along with only measurements only. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
% Notice: this method assumes that the initial location of the control
%         point is at [0 0 0]. If the control point does not start at zero,
%         then one should consider offsets for all locations. 

%------------------
% Check all values:
% trying to make three cases only: 1 dof, 3 dof (2 tran + 1 rot), 6 dof
%------------------
ind_tran = find(idof(1:3) == 1);
ind_rot = find(idof(4:6) == 1);
%==
idof_update = zeros(size(idof));
if ~isempty(ind_tran)
    if length(ind_tran) == 1
        idof_update(ind_tran) = 1;
    end
    if length(ind_tran) == 2
        temp = [1 2 3];
        itemp = find((temp~=ind_tran(1))&(temp~=ind_tran(2)));
        idof_update(itemp+3) = 1;
        idof_update(ind_tran) = ones(1,2);
    end
    if length(ind_tran) == 3
        idof_update = ones(1,6);
    end
end
if ~isempty(ind_rot)
    temp = [2 3;3 1;1 2];
    if length(ind_rot) == 1
        idof_update(ind_rot+3*ones(1,length(ind_rot))) = ones(1,length(ind_rot));
        idof_update(1,temp(ind_rot,:)) = ones(1,2);
    else
        idof_update(1,:) = ones(1,6);
    end
end

%------------------
% check required # of sensors
%------------------
num_sensor = length(d);
num_control = sum(idof_update);
%==
temp = num_sensor + num_sensor*(num_sensor-1)/2;
if temp < num_control
    error('Number of external sensors is not sufficient');
end

%------------------
% optimization setting
%------------------
opt = optimset('MaxFunEvals',optm.maxfunevals,'MaxIter',optm.maxiter,...
               'TolFun',optm.tolfun,'TolX',optm.tolx,...
               'Jacobian',optm.jacob,'Display','off','LevenbergMarquardt','on');
%==
UB = [30*ones(1,3) pi/5*ones(1,3)]';% should be modified, could be in me.optSetting
LB = -UB;% should be modified, could be in me.optSetting

%------------------
% Perturbation
%------------------
cmdpert = optm.pert_total;

%------------------
% Update variable
%------------------
ind_dof = find(idof_update == 1);

%------------------
% obtain cmd
%------------------
switch imode
    case 100 %dont use, will be modified later
        cmdtemp = lsqnonlin(@(cmd) ElasticDeformation.x2cmd_eval(cmd,xcurrent,xpin,xfix,d),cmdlast',LB,UB,opt);
        cmd = cmdtemp';
    case 30 %it doesn't require optimization function
        %--------------------
        % Update variable
        %--------------------
        ind_dof = find(idof_update == 1);
        %==
        UB_check = UB(ind_dof);
        LB_check = LB(ind_dof);
        %==
        INI_check = zeros(length(ind_dof),1);
        %==
        lamda = 0.75/2; %0.25 - 5
        
        %--------------------
        % first step
        %--------------------
        cmdtemp = INI_check;        
        [fxtemp,Jtemp] = ElasticDeformation.x2cmd_eval2_mf(cmdtemp,xpin,xfix,d,cmdlast',idof_update,cmdpert); 
        normtemp = 0;
        
        %--------------------
        % Iteration
        %--------------------
        for i = 1:optm.maxfunevals
            [fx,Jac] = ElasticDeformation.x2cmd_eval2_mf(cmdtemp,xpin,xfix,d,cmdlast',idof_update,cmdpert);
            delta_cmdtemp = inv(Jac'*Jac+lamda*diag(diag(Jac'*Jac)))*Jac'*(fx);
            cmdnew = - delta_cmdtemp + cmdtemp;
            %== check whether 'cmdnew' is within boundary or not
            for j = 1:optm.maxiter
                %== check lower bond
                temp = cmdnew-LB_check;
                ind1 = find(temp < 0);
                %== check upper bond
                temp = UB_check-cmdnew;
                ind2 = find(temp < 0);
                %==
                if isempty(ind1) && isempty(ind2)
                    break
                else
                    if ~isempty(ind1)
                        cmdnew(ind1) = LB_check(ind1);
                    elseif ~isempty(ind2) 
                        cmdnew(ind2) = UB_check(ind2);
                    end
                    normtemp = norm(fx-fxtemp);
                    [fx,Jac] = ElasticDeformation.x2cmd_eval2_mf(cmdnew,xpin,xfix,d,cmdlast',idof_update,cmdpert);
                    delta_cmdtemp = inv(Jac'*Jac+lamda*diag(diag(Jac'*Jac)))*Jac'*(fx);
                    cmdnew = -delta_cmdtemp + cmdnew;
                    if norm(fx-fxtemp) > normtemp
                        lamda = 0.05;%0.75/2-0.25/2;                        
                    else
                        lamda = 0.75/2;
                    end
                    fxtemp = fx;
                end 
            end
            %== check tolerance for "cmdnew" and "fx"           
            if norm(delta_cmdtemp) < optm.tolx && norm(fx-fxtemp) < optm.tolfun
                break
            else                
                cmdtemp = cmdnew;
                if norm(fx-fxtemp) > normtemp
                        lamda = 0.15;
                else
                        lamda = 0.375;
                end                    
                normtemp = fx-fxtemp;
                fxtemp = fx;
            end                                        
            %==
        end        
        %==
        cmd = zeros(1,6);
        cmd(ind_dof) = cmdnew';
        
    case 3
        cmdtemp = lsqnonlin(@(cmd) ElasticDeformation.x2cmd_eval2_mf(cmd,xpin,xfix,d,cmdlast',idof_update,cmdpert),zeros(length(ind_dof),1),LB(ind_dof),UB(ind_dof),opt);
        cmd = zeros(1,6);
        cmd(ind_dof) = cmdtemp';
end