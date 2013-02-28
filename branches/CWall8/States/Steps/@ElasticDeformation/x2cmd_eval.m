function [fx,Jac] = x2cmd_eval(cmd,xnow,xpin,xfix,d)

%------------------
% break into translational and rotational
% cmd should be 6x1
%------------------
ns = size(xpin,2);
%==
rot = cmd(4:6);
tran = cmd(1:3);
%==


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
temp = xnow_cal-xnow;
dtemp1 = reshape(temp,3*ns,1);
%==
temp = xnow_cal-xfix;
temp2 = xpin-xfix;
dtemp2 = zeros(ns,1);
for i = 1:ns
    dtemp2(i) = norm(temp(:,i))-d(i)-norm(temp2(:,i));
end
%==
dtemp3 = zeros(ns*(ns-1)/2,1);
dtemp4 = zeros(ns*(ns-1)/2,1);
istep = 1;
for i = 1:(ns-1)
    for j = (i+1):ns
        dtemp3(istep) = norm(xnow_cal(:,i)-xnow_cal(:,j))-norm(xpin(:,i)-xpin(:,j));
        dtemp4(istep) = norm(xnow_cal(:,i)-xnow_cal(:,j))-norm(xnow(:,i)-xnow(:,j));
        istep = istep+1;
    end
end

%------------------
% evaluation function
%------------------
fx = [dtemp1;dtemp2;dtemp3;dtemp4];


%------------------
% calculate Jacobian
%------------------
Jac = zeros(length(fx),length(cmd));
%==
x = [ones(3,1);0.005*ones(3,1)];
for i = 1:6
    cmdtemp = zeros(6,1);cmdtemp(i) = cmd(i)+x(i);
    rot = cmdtemp(4:6);tran = cmdtemp(1:3);
    %==
    T1 = [1 0 0;0 cos(rot(1)) -sin(rot(1));0 sin(rot(1)) cos(rot(1))];
    T2 = [cos(rot(2)) 0 sin(rot(2));0 1 0;-sin(rot(2)) 0 cos(rot(2))];
    T3 = [cos(rot(3)) -sin(rot(3)) 0;sin(rot(3)) cos(rot(3)) 0;0 0 1];
    Tall = T3*T2*T1;
    %==
    xnow_cal = Tall*xpin + kron(ones(1,ns),tran);
    %==
    temp = xnow_cal-xpin;
    dtemp1 = reshape(temp,3*ns,1);
    %==
    temp = xnow_cal-xfix;
    dtemp2 = zeros(ns,1);
    for ii = 1:ns
        dtemp2(ii) = norm(temp(:,ii))-norm(temp2(:,ii));
    end
    %==
    dtemp3 = zeros(ns*(ns-1)/2,1);
    dtemp4 = zeros(ns*(ns-1)/2,1);
    istep = 1;
    for ii = 1:(ns-1)
        for jj = (ii+1):ns
            dtemp3(istep) = norm(xnow_cal(:,ii)-xnow_cal(:,jj))-norm(xpin(:,ii)-xpin(:,jj));
            dtemp4(istep) = norm(xnow_cal(:,ii)-xnow_cal(:,jj))-norm(xpin(:,ii)-xpin(:,jj));
            istep = istep+1;
        end
    end
    %==
    Jac(:,i) = 1/cmdtemp(i)*[dtemp1;dtemp2;dtemp3;dtemp4];
end
%}


