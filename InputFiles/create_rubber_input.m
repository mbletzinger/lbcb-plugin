clear; clc; close all

amps=[0.1 0.2 0.3 0.4 0.5];

dx=[linspace(0,0.2,1) linspace(0.2,-0.2,2) linspace(-0.2,0.4,3) ...
    linspace(0.4,-0.4,4) linspace(-0.4,0.6,5) linspace(0.6,-0.6,6) ...
    linspace(-0.6,0.8,7) linspace(0.8,-0.8,8) linspace(-0.8,1.0,9) ...
    linspace(1.0,-1.0,10) linspace(-1.0,0,5)]';
ptime=[1:length(dx)]';
Fz=[linspace(0,300,5)'; 300*ones(length(ptime),1)];
totaltime=length(Fz);

figure; plot(ptime,dx);

load=[[zeros(5,1); dx] Fz zeros(totaltime,1)];
load2=[[zeros(5,1); dx] Fz];

fid=fopen('rubberload.txt','w');
fid2=fopen('rubberload2.txt','w');

for ii=1:totaltime;
    fprintf(fid,'%5.4f %5.4f %5.4f \n',load(ii,:));
    fprintf(fid2,'%5.4f %5.4f \n',load2(ii,:));
end
fclose('all');