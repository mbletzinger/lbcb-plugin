%

%% stiffness Dx
Mag = 0.05;
stepAct = 0.01;
Dx = oneLoadCase(Mag, ceil(Mag/stepAct), 3);

fid1=fopen('Eval_stiff_dx_disp.txt','w');

for ii=1:length(Dx);
    fprintf(fid1,'%5.4f \n',Dx(ii));
end

fid2=fopen('Eval_stiff_dx_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[1 0 0 0 0 0 0 0 0 0 0 0]);
fclose(fid2);
figure; 

plot(Dx, '*-')


%% stiffness Ry

Mag = 0.005;
stepAct = 0.001;
ry = oneLoadCase(Mag, ceil(Mag/stepAct), 3);

fid1=fopen('Eval_stiff_ry_disp.txt','w');

for ii=1:length(ry);
    fprintf(fid1,'%5.4f \n',ry(ii));
end

fid2=fopen('Eval_stiff_ry_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 0 0 1 0 0 0 0 0 0 0]);
fclose(fid2);
figure; 

plot(ry, '*-')




%% stiffness Dz

Mag = 0.04;
stepAct = 0.005;
Dz = abs(oneLoadCase(Mag, ceil(Mag/stepAct), 3));

fid1=fopen('Eval_stiff_dz_disp.txt','w');

for ii=1:length(Dz);
    fprintf(fid1,'%5.4f \n',Dz(ii));
end

fid2=fopen('Eval_stiff_dz_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[0 0 1 0 0 0 0 0 0 0 0 0]);
fclose(fid2);
figure; 

plot(Dz, '*-')