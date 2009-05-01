function obj = query_mean(obj, varargin)

if obj.NoiseCompensation == 0
        NumSample = 1;
elseif obj.NoiseCompensation == 1
        NumSample = obj.NumSample;
end

if length(varargin) == 1 
        NumSample = varargin{1};                % override 
end

LBCBForc  = zeros(NumSample,6);
LBCBDisp  = zeros(NumSample,6);
Aux_Disp  = zeros(NumSample,3);

for i=1:NumSample
        obj = query(obj);
        LBCBForc1(i,:) = [obj.M_Forc1'   ];%'
        LBCBDisp1(i,:) = [obj.M_Disp1'   ];%'
        Aux_Disp1(i,:) = [obj.M_AuxDisp1'];%'

        LBCBForc2(i,:) = [obj.M_Forc2'   ];%'
        LBCBDisp2(i,:) = [obj.M_Disp2'   ];%'
        Aux_Disp2(i,:) = [obj.M_AuxDisp2'];%'
end  
                             
obj.M_Forc1    = mean(LBCBForc1,1)';%'
obj.M_Disp1    = mean(LBCBDisp1,1)';%'
obj.M_AuxDisp1 = mean(Aux_Disp1,1)';%'

obj.M_Forc2    = mean(LBCBForc2,1)';%'
obj.M_Disp2    = mean(LBCBDisp2,1)';%'
obj.M_AuxDisp2 = mean(Aux_Disp2,1)';%'


if obj.DispMesurementSource == 0                % do nothing

elseif obj.DispMesurementSource == 1            % convert stringpot readings to model coordinate system
        [obj.M_Disp1 obj.Aux_State1] = Extmesu2Cartesian(obj.M_AuxDisp1,obj.Aux_State1,obj.Aux_Config1);
        [obj.M_Disp2 obj.Aux_State2] = Extmesu2Cartesian(obj.M_AuxDisp2,obj.Aux_State2,obj.Aux_Config2);
        
end


%%% debugging code =================================================================================================================================
obj.M_Disp1 = obj.T_Disp(1:6);  
obj.M_Disp2 = obj.T_Disp(7:12);  
Test_Config;
zer = zeros(3,3);

d1 = inv([T1 zer; zer T1])*obj.M_Disp1;         % convert LBCB coordinate system to model coordinate system
d2 = inv([T2 zer; zer T2])*obj.M_Disp2;         % convert LBCB coordinate system to model coordinate system

D = [d2(1) d2(2) d2(6) d1(1) d1(2) d1(6)]';     %' %coordinate conversion, 1/6 scale
% stiffness of 1/6 scale connection (beam, column top). Model coordinate system (beam x y rz column x y rz)
%K = [1.613417E+02      2.167434E+00    1.688544E+01    -9.390025E+01   -1.223130E+00   -6.886129E+02
%     2.170468E+00      1.256054E+01    1.472986E+02    -7.513618E+00   -7.075091E+00   -3.698318E+01
%     1.738921E+01      1.473078E+02    2.300468E+03    -6.018049E+01   -8.297399E+01   -2.957621E+02
%     -9.389890E+01     -7.511194E+00   -5.989136E+01   6.971625E+01    4.231716E+00    6.199103E+02
%     -1.196790E+00     -7.074738E+00   -8.294954E+01   4.255897E+00    1.189564E+03    2.398242E+01
%     -6.885567E+02     -3.691663E+01   -2.936980E+02   6.198268E+02    2.079957E+01    8.037737E+03]*1000; 


% stiffness matrix assuming column axial force is uncoupled
K = [1.613417E+02       2.167434E+00    1.688544E+01    -9.390025E+01   0   -6.886129E+02
     2.170468E+00       1.256054E+01    1.472986E+02    -7.513618E+00   0   -3.698318E+01
     1.738921E+01       1.473078E+02    2.300468E+03    -6.018049E+01   0   -2.957621E+02
    -9.389890E+01      -7.511194E+00   -5.989136E+01     6.971625E+01   0    6.199103E+02
             0                  0               0                0      0            0 
    -6.885567E+02      -3.691663E+01   -2.936980E+02     6.198268E+02   0    8.037737E+03]*1000; 


F = K*D;

F2 = [F(1) F(2) 0 0 0 F(3)]'; %'        % Forces in model coordinate system
F1 = [F(4) F(5) 0 0 0 F(6)]'; %'        % Forces in model coordinate system

F2 = [T2 zer; zer T2r]*F2;              % Convert forces to LBCB coordinate system
F1 = [T1 zer; zer T1r]*F1;              % Convert forces to LBCB coordinate system

        
obj.M_Forc1 = F1;                       
obj.M_Forc2 = F2;
%%% ========================================================================================================================================== %%%

obj.M_Forc1(3) = obj.M_Disp1(3)* (1.189564E+06);

obj.M_Disp = [obj.M_Disp1;obj.M_Disp2]; % Measured displacement, LBCB1 coordiante, LBCB2 coordinate
obj.M_Forc = [obj.M_Forc1;obj.M_Forc2];

if (obj.curStep > 0)                       
        obj.mDisp_history(obj.curStep,:) = obj.M_Disp';%'
        obj.mForc_history(obj.curStep,:) = obj.M_Forc';%'
end
