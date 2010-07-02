clear; clc; close all

load=textread('concreteload.txt');

dx=load(6:end,1);

dx_short=dx(1:4:end);
figure; plot(dx_short);
Fz_short=[linspace(0,450,5)'; 450*ones(length(dx_short),1)];
dx_short=[zeros(5,1); dx_short];
My_short=zeros(length(dx_short),1);

fid1=fopen('concreteload_short.txt','w+');
for ii=1:length(dx_short);
    fprintf(fid1,'%5.4f %5.4f %5.4f \n',[dx_short(ii) Fz_short(ii) My_short(ii)]);
end
fclose('all');