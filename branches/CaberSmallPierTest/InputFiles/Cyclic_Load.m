
stepAct = 0.03;
Dx1 = oneLoadCase(0.05, ceil(0.05/stepAct), 3);
Dx2 = oneLoadCase( 0.1, ceil(0.1/stepAct), 3);
Dx3 = oneLoadCase( 0.2, ceil(0.2/stepAct), 3);
Dx4 = oneLoadCase( 0.3, ceil(0.3/stepAct), 3);
Dx5 = oneLoadCase( 0.4, ceil(0.4/stepAct), 3);
Dx6 = oneLoadCase( 0.5, ceil(0.5/stepAct), 3);
Dx7 = oneLoadCase( 0.6, ceil(0.6/stepAct), 3);
Dx8 = oneLoadCase( 0.7, ceil(0.7/stepAct), 3);

Dx = [Dx1; Dx2(2:end); Dx3(2:end); Dx4(2:end); Dx5(2:end); Dx6(2:end); Dx7(2:end); Dx8(2:end)];

Dx = [zeros(10,1); Dx];

Fz = zeros(length(Dx), 1);
Fz(1:10, 1) = linspace(0, 1600, 10)'; 
Fz(11: length(Dx), 1) = 1600;

close all;
figure; subplot(211); plot(Dx, '.-'); subplot(212), plot(Fz,'.-')

fid1=fopen('Cyclic_dx_disp.txt','w');

for ii=1:length(Dx);
    fprintf(fid1,'%5.4f %5.4f \n',Dx(ii), Fz(ii));
end

fid2=fopen('Cyclic_dx_disp_spec.txt','w');
fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d \n',[1 0 0 0 0 0 0 0 1 0 0 0]);

