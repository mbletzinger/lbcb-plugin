function [fx,Jac] = x2cmd_eval2_mf(cmd,xpin,xfix,d,cmdlast,idof,cmdpert)

%------------------
% Obtain full "cmd"
%------------------
ind_dof = find(idof == 1);
temp = cmd;
cmd = zeros(6,1);
cmd(ind_dof) = temp;

%------------------
% break into translational and rotational
% cmd should be 6x1
%------------------
ns = size(xpin,2);
%==
cmd = cmd+cmdlast;
rot = cmd(4:6);
tran = cmd(1:3);
%==

%------------------
% position at last step
%------------------
rot1 = cmdlast(4:6);tran1 = cmdlast(1:3);
T1 = [1 0 0;0 cos(rot1(1)) -sin(rot1(1));0 sin(rot1(1)) cos(rot1(1))];
T2 = [cos(rot1(2)) 0 sin(rot1(2));0 1 0;-sin(rot1(2)) 0 cos(rot1(2))];
T3 = [cos(rot1(3)) -sin(rot1(3)) 0;sin(rot1(3)) cos(rot1(3)) 0;0 0 1];
Tall = T3*T2*T1;
xlast = Tall*xpin + kron(ones(1,ns),tran1);


%------------------
% transformation matrix
%------------------
T1 = [1 0 0;0 cos(rot(1)) -sin(rot(1));0 sin(rot(1)) cos(rot(1))];
T2 = [cos(rot(2)) 0 sin(rot(2));0 1 0;-sin(rot(2)) 0 cos(rot(2))];
T3 = [cos(rot(3)) -sin(rot(3)) 0;sin(rot(3)) cos(rot(3)) 0;0 0 1];
Tall = T3*T2*T1;

%------------------
% obtain calculated xnow
%------------------
xnow_cal = Tall*xpin + kron(ones(1,ns),tran);


%------------------
% calculated lengths
%------------------
temp = xnow_cal-xfix;
temp2 = xpin-xfix;
dtemp1 = zeros(ns,1);
for i = 1:ns
    dtemp1(i) = norm(temp(:,i))-d(i)-norm(temp2(:,i));
end
%==
dtemp3 = zeros(ns*(ns-1)/2,1);
dtemp4 = zeros(ns*(ns-1)/2,1);
istep = 1;
for i = 1:(ns-1)
    for j = (i+1):ns
        dtemp3(istep) = norm(xnow_cal(:,i)-xnow_cal(:,j))-norm(xpin(:,i)-xpin(:,j));
        dtemp4(istep) = norm(xnow_cal(:,i)-xnow_cal(:,j))-norm(xlast(:,i)-xlast(:,j));
        istep = istep+1;
    end
end

%------------------
% evaluation function
%------------------
fx = [dtemp1;dtemp3;dtemp4];


%------------------
% calculate Jacobian
%------------------
Jac = zeros(length(fx),length(ind_dof));
%==
x = cmdpert;%[ones(3,1);0.005*ones(3,1)];
for i = 1:length(ind_dof)
    cmdtemp = zeros(6,1);
    temp = cmd(ind_dof(i)) + x(ind_dof(i));
    if abs(temp) < 1e-3
        x(ind_dof(i)) = x(ind_dof(i)) + 1e-3;
    end
    cmdtemp(ind_dof(i)) = cmd(ind_dof(i))+x(ind_dof(i));
    rot = cmdtemp(4:6)+cmdlast(4:6);tran = cmdtemp(1:3)+cmdlast(1:3);
    %==
    T1 = [1 0 0;0 cos(rot(1)) -sin(rot(1));0 sin(rot(1)) cos(rot(1))];
    T2 = [cos(rot(2)) 0 sin(rot(2));0 1 0;-sin(rot(2)) 0 cos(rot(2))];
    T3 = [cos(rot(3)) -sin(rot(3)) 0;sin(rot(3)) cos(rot(3)) 0;0 0 1];
    Tall = T3*T2*T1;
    %==
    xnow_cal = Tall*xpin + kron(ones(1,ns),tran);
    
    %==
    temp = xnow_cal-xfix;
    temp3 = xlast-xfix;
    dtemp1 = zeros(ns,1);
    for ii = 1:ns
        dtemp1(ii) = norm(temp(:,ii))-norm(temp3(:,ii));
    end
    %==
%     temp = xnow_cal-xfix;
%     temp2 = xlast-xfix;
%     dtemp2 = zeros(ns,1);
%     for ii = 1:ns
%         dtemp2(ii) = norm(temp(:,ii))-norm(temp2(:,ii));
%     end
    %==
    dtemp3 = zeros(ns*(ns-1)/2,1);
    dtemp4 = zeros(ns*(ns-1)/2,1);
    istep = 1;
    for ii = 1:(ns-1)
        for jj = (ii+1):ns
            dtemp3(istep) = norm(xnow_cal(:,ii)-xnow_cal(:,jj))-norm(xlast(:,ii)-xlast(:,jj));
            dtemp4(istep) = norm(xnow_cal(:,ii)-xnow_cal(:,jj))-norm(xlast(:,ii)-xlast(:,jj));
            istep = istep+1;
        end
    end
    %==
    Jac(:,i) = 1/cmdtemp(ind_dof(i))*[dtemp1;dtemp3;dtemp4];
end
%}


