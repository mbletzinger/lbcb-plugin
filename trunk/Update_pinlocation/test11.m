clc
%------------------
% load files
%------------------
% load exp1
%==
load pinloc

%------------------
% cmd
%------------------
% cmd_total = data_lbcb(:,7:12);
% cmd_orig = data_lbcb(:,1:6);

%------------------
% external sensor
%------------------
sens = [0.9979 0.9976 1.002 1.0341 0.9995 1.0009]';
%==
% temp_ini = data_ext(1,:);
% data_ext = data_ext*diag(sens);
% data_ext = data_ext-kron(ones(size(data_ext,1),1),data_ext(1,:));

%------------------
% obtain initial pinlocation
%------------------
temp_ini = [0.830207 1.06098 0.989817 2.89699 1.09679 0.88076];
ini_read = [0.828892 1.04868 1.00496 2.85417 1.09996 0.950144];
temp_len_change = (temp_ini-ini_read).*sens';
dold1 = [8.625 12.28125 17.5 15.875 17.9375 17.5625]'+temp_len_change';
%==
dold2 = zeros(6*5/2,1);
istep = 1;
for i = 1:5
    for j = (i+1):6
        dold2(istep) = norm(xpin_nominal(i,:)-xpin_nominal(j,:));
        istep = istep+1;
    end
end
dtotal = [dold1;dold2];
clear dold1 dold2
%==
opt = optimset('MaxFunEvals',20000,'MaxIter',20000,'TolFun',1e-24,'TolX',1e-30,...
      'LevenbergMarquardt','on');%'Jacobian','on',
%==
x0 = reshape(xpin',3*6,1);
LB = kron(ones(6,1),[-10 -9 -1]');
UB = kron(ones(6,1),[10 9 7]');
%==
xtemp = lsqnonlin(@(x) pinfreeini(x,xfix',dtotal),x0,LB,UB,opt);
xpin = reshape(xtemp,3,6)';