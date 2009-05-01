obj.M_Forc1    = [6.129811E+0	-1.424794E+0	-1.745592E+1	1.314340E+1	-4.773574E+1	-8.194241E-1]';%'
obj.M_Forc2    = [1.105503E+0	-6.337135E+0	-8.872243E+0	-5.289765E+1	-8.452417E+0	-7.953307E+0]';%'

	
	


%%% debugging code =================================================================================================================================
% measured force vector (beam, x z ry, column x z ry)
Fr = [obj.M_Forc2(1) obj.M_Forc2(3) obj.M_Forc2(5) obj.M_Forc1(1) obj.M_Forc1(3) obj.M_Forc1(5)]';%'

% scale factor to convert forces from rubber specimen to forces from steel specimen
S = 1.0e+004 * [-0.049220490163539   0.002954399128202   0.001136696911082   0.235006088509275  -0.200835223905249  -0.024614541316224
                 0.469304236468053   0.152256465431144  -0.033726321783140  -0.569137959888154   0.105421965804153   0.033137559369894
                -0.790085392901964  -0.059852201884016   0.111763064994646   2.650128568934677  -1.325980145801836  -0.234653082381420
                -0.022652271120041  -0.000114158392559   0.000081287592390   0.208341944996146  -0.041819200787829  -0.015107951799951
                 0.119987062601244  -0.010623358915248   0.005719961998082  -0.188474366707652   0.370519037600815   0.026833023249719
                 0.572591020368325   0.006431261946612  -0.005103817495182  -2.820858702285280   0.703779470745713   0.211417501475110];
F = S*Fr;
obj.M_Forc2(1) = F(1);
obj.M_Forc2(3) = F(2);
obj.M_Forc2(5) = F(3);
obj.M_Forc1(1) = F(4);
obj.M_Forc1(3) = F(5);
obj.M_Forc1(5) = F(6);

%%% ========================================================================================================================================== %%%

% override vertical force of LBCB1
%obj.M_Forc1(3) = obj.M_Disp1(3)* (1.189564E+06);
obj.M_Forc1(3) = 4.760957E-4 * (1.189564E+06);

obj.M_Forc = [obj.M_Forc1;obj.M_Forc2];


Test_Config;
SF   = [ScaleF ScaleF ScaleF 1 1 1]';			%'% scale factor, displacement + rotation
SF_f = [ScaleF^2 ScaleF^2 ScaleF^2 ScaleF^3 ScaleF^3 ScaleF^3]';	%'% scale factor, force + moment
zer = zeros(3,3);


MF2 = obj.M_Forc(7:12)/1000;		% measured force at beam node, conversion from lb to kip
MF3 = obj.M_Forc(1:6)/1000;		% measured force at column top, conversion from lb to kip

MF2 = (1./SF_f).*(inv([T2 zer; zer T2r])*MF2);	% command to LBCB2 
MF3 = (1./SF_f).*(inv([T1 zer; zer T1r])*MF3);	% command to LBCB1

MF2      = MF2([1 2 6]);		% model space
MF3      = MF3([1 2 6]);		% model space
MF1      = zeros(size(MF2));		% support reaction from equilibrium

MF1(1:2) = -(MF2(1:2)+MF3(1:2));
MF1(3)   = -(MF2(3)+MF3(3)) + MF3(1)*(coord_n3(2) - coord_n1(2)) + MF2(1)*(coord_n2(2) - coord_n1(2)) + MF2(2)*(coord_n1(1) - coord_n2(1));

