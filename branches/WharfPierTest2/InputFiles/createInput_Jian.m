%% Ry stiffness, force control

mag = 1000;
a = load('unitsawtooth.dat');

My = a.*mag;

Fx = a.*0;

fid1=fopen('Eval_stiff_ry_force.txt','w');

for ii=1:length(My);
    fprintf(fid1,'%5.4f %5.4f \n',[Fx(ii) My(ii)]);
end

fid2=fopen('Eval_stiff_ry_force_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 0 0 0 0 1 0 0 0 1 0]);

figure; 

plot(My)

%% Dx stiffness, displacement control

mag = 0.06;
num_steps = 10;
num_cycles = 5;
Dx = zeros(num_steps*4*num_cycles+1,1);

for i = 1 : num_cycles
   Dx(4*num_steps*(i-1) + 1:4*num_steps*(i-1) + num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Dx(4*num_steps*(i-1) + num_steps + 1:4*num_steps*(i-1) +  2*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
   Dx(4*num_steps*(i-1) + 2*num_steps + 1:4*num_steps*(i-1) + 3*num_steps + 1, 1) = -linspace(0, mag, num_steps+1)';
   Dx(4*num_steps*(i-1) + 3*num_steps + 1:4*num_steps*(i-1) + 4*num_steps + 1, 1) = -linspace(mag,0, num_steps+1)';
end

fid1=fopen('Eval_stiff_dx_disp.txt','w');

for ii=1:length(Dx);
    fprintf(fid1,'%5.4f \n',Dx(ii));
end

fid2=fopen('Eval_stiff_dx_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[1 0 0 0 0 0 0 0 0 0 0 0]);

figure; 

plot(Dx)

%% Ry stiffness, displacement control

mag = 0.01;
num_steps = 10;
num_cycles = 5;
Ry = zeros(num_steps*4*num_cycles+1,1);

for i = 1 : num_cycles
   Ry(4*num_steps*(i-1) + 1:4*num_steps*(i-1) + num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Ry(4*num_steps*(i-1) + num_steps + 1:4*num_steps*(i-1) +  2*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
   Ry(4*num_steps*(i-1) + 2*num_steps + 1:4*num_steps*(i-1) + 3*num_steps + 1, 1) = -linspace(0, mag, num_steps+1)';
   Ry(4*num_steps*(i-1) + 3*num_steps + 1:4*num_steps*(i-1) + 4*num_steps + 1, 1) = -linspace(mag,0, num_steps+1)';
end

fid1=fopen('Eval_stiff_ry_disp.txt','w');

for ii=1:length(Ry);
    fprintf(fid1,'%5.4f \n',Ry(ii));
end

fid2=fopen('Eval_stiff_ry_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 0 0 1 0 0 0 0 0 0 0]);

figure; 

plot(Ry)

%% Dz stiffness, force control

mag = 2500;
num_steps = 10;
num_cycles = 5;
Fz = zeros(num_steps*4*num_cycles+1,1);

for i = 1 : num_cycles
   Fz(4*num_steps*(i-1) + 1:4*num_steps*(i-1) + num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Fz(4*num_steps*(i-1) + num_steps + 1:4*num_steps*(i-1) +  2*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
   Fz(4*num_steps*(i-1) + 2*num_steps + 1:4*num_steps*(i-1) + 3*num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Fz(4*num_steps*(i-1) + 3*num_steps + 1:4*num_steps*(i-1) + 4*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
end

fid1=fopen('Eval_stiff_Dz_force.txt','w');

for ii=1:length(Fz);
    fprintf(fid1,'%5.4f \n',Fz(ii));
end

fid2=fopen('Eval_stiff_Dz_force_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 0 0 0 0 0 0 1 0 0 0]);

figure; 

plot(Fz)

%% Dz stiffness, displacement control

mag = 0.06;
a = load('unitsawtooth.dat');

a = abs(a);

Dz = a.*mag;

fid1=fopen('Eval_stiff_Dz_disp.txt','w');

for ii=1:length(Dz);
    fprintf(fid1,'%5.4f \n',Dz(ii));
end

fid2=fopen('Eval_stiff_Dz_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 1 0 0 0 0 0 0 0 0 0]);

figure; 

plot(Dz)

%% Dx stiffness, displacement and force control

mag = 0.05;
num_steps = 6;
num_cycles = 5;
Dx = zeros(num_steps*4*num_cycles+1,1);

for i = 1 : num_cycles
   Dx(4*num_steps*(i-1) + 1:4*num_steps*(i-1) + num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Dx(4*num_steps*(i-1) + num_steps + 1:4*num_steps*(i-1) +  2*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
   Dx(4*num_steps*(i-1) + 2*num_steps + 1:4*num_steps*(i-1) + 3*num_steps + 1, 1) = -linspace(0, mag, num_steps+1)';
   Dx(4*num_steps*(i-1) + 3*num_steps + 1:4*num_steps*(i-1) + 4*num_steps + 1, 1) = -linspace(mag,0, num_steps+1)';
end

fid1=fopen('Eval_stiff_dx_disp.txt','w');

for ii=1:length(Dx);
    fprintf(fid1,'%5.4f %5.4f \n',Dx(ii), 0.00);
end

fid2=fopen('Eval_stiff_dx_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[1 0 0 0 0 0 0 0 0 0 1 0]);

figure; 

plot(Dx,'*-')

%% Ry stiffness, displacement and force control

mag = 0.006;
num_steps = 5;
num_cycles = 5;
Ry = zeros(num_steps*4*num_cycles+1,1);

for i = 1 : num_cycles
   Ry(4*num_steps*(i-1) + 1:4*num_steps*(i-1) + num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Ry(4*num_steps*(i-1) + num_steps + 1:4*num_steps*(i-1) +  2*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
   Ry(4*num_steps*(i-1) + 2*num_steps + 1:4*num_steps*(i-1) + 3*num_steps + 1, 1) = -linspace(0, mag, num_steps+1)';
   Ry(4*num_steps*(i-1) + 3*num_steps + 1:4*num_steps*(i-1) + 4*num_steps + 1, 1) = -linspace(mag,0, num_steps+1)';
end

fid1=fopen('Eval_stiff_ry_disp.txt','w');

for ii=1:length(Ry);
    fprintf(fid1,'%5.4f %5.4f \n',Ry(ii), 0);
end

fid2=fopen('Eval_stiff_ry_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 0 0 1 0 1 0 0 0 0 0]);

figure; 

plot(Ry)