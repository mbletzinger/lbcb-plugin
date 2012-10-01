clear; clc; close all;

dx=0:0.1:1.9;
dx=[dx fliplr(dx(1:end-1)) -dx(2:end)];
dy=0:0.1:0.7;
dy=[dy fliplr(dy(1:end-1)) -dy(2:end)];
dz=0:0.05:0.4;
dz=[dz fliplr(dz(1:end-1)) -dz(2:end)];
rx=0:0.01:0.1;
rx=[rx fliplr(rx(1:end-1)) -rx(2:end)];
ry=0:0.01:0.1;
ry=[ry fliplr(ry(1:end-1)) -ry(2:end)];
rz=0:0.01:0.1;
rz=[rz fliplr(rz(1:end-1)) -rz(2:end)];

dx2=0:0.1:0.9;
dx2=[dx2 fliplr(dx2(1:end-1)) -dx2(2:end)];
dz2=0:0.03:0.27;
dz2=[dz2 fliplr(dz2(1:end-1)) -dz2(2:end)];
ry2=0:0.002:0.018;
ry2=[ry2 fliplr(ry2(1:end-1)) -ry2(2:end)];

fid1=fopen('checkdx.txt','w');
fid2=fopen('checkdy.txt','w');
fid3=fopen('checkdz.txt','w');
fid4=fopen('checkrx.txt','w');
fid5=fopen('checkry.txt','w');
fid6=fopen('checkrz.txt','w');
fid7=fopen('combdxdzrx.txt','w');


for ii=1:length(dx);
    fprintf(fid1,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[dx(ii) 0 0 0 0 0]);
end
for ii=1:length(dy);
    fprintf(fid2,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[0 dy(ii) 0 0 0 0]);
end
for ii=1:length(dz);
    fprintf(fid3,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[0 0 dz(ii) 0 0 0]);
end
for ii=1:length(rx);
    fprintf(fid4,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[0 0 0 rx(ii) 0 0]);
    fprintf(fid5,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[0 0 0 0 ry(ii) 0]);
    fprintf(fid6,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[0 0 0 0 0 rz(ii)]);
end
for ii=1:length(dx2);
    fprintf(fid7,'%5.4f %5.4f %5.4f %5.4f %5.4f %5.4f \n',[dx2(ii) 0 dz2(ii) 0 ry2(ii) 0]);
end

fclose('all');