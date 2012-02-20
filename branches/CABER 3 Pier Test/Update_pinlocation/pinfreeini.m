function [fx,Jac] = pinfreeini(x,xfix,dtotal)

%------------------
% initial values
%------------------
ns = size(xfix,2);
%==
x = reshape(x,3,ns);

%------------------
% obtain all lengths
%------------------
dtemp1 = sqrt(diag((x-xfix)'*(x-xfix)));
dtemp2 = zeros(ns*(ns-1)/2,1);
%~~
istep = 1;
for i = 1:(ns-1)
    for j = (i+1):ns
        dtemp2(istep) = norm(x(:,i)-x(:,j));
        istep = istep+1;
    end
end
%~~
dnow = [dtemp1;dtemp2];

%------------------
% Evaluation function
%------------------
fx = dnow-dtotal;


%------------------
% Jacobian
%------------------
dtemp3 = zeros(ns*(ns-1)/2,1);
istep = 1;
for i = 1:(ns-1)
    for j = (i+1):ns
        dtemp3(istep) = norm(x(:,i)-x(:,j));
        istep = istep+1;
    end
end
%==
Jac = zeros(length(fx),ns*3);
%==
for i = 1:(ns*3)
    xtemp = reshape(x,3*ns,1); xtemp(i) = 0.01 + xtemp(i);
    xtemp = reshape(xtemp,3,ns);
    %==
    dtemp1 = sqrt(diag((xtemp-xfix)'*(xtemp-xfix)));
    dtemp2 = zeros(ns*(ns-1)/2,1);
    %~~
    istep = 1;
    for ii = 1:(ns-1)
        for jj = (ii+1):ns
            dtemp2(istep) = norm(xtemp(:,ii)-xtemp(:,jj));
            istep = istep+1;
        end
    end
    %==
    Jac(:,i) = 1/0.01*[dtemp1;(dtemp2-dtemp3)];
end
%}