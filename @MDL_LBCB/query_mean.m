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

obj.M_Disp = [obj.M_Disp1;obj.M_Disp2]; % Measured displacement, LBCB1 coordiante, LBCB2 coordinate
obj.M_Forc = [obj.M_Forc1;obj.M_Forc2];


%%% debugging code =================================================================================================================================

Test_Config;
obj.M_Disp = obj.M_Disp / cmd_scale_rubber;
obj.M_Forc = obj.M_Forc / cmd_scale_rubber;



%%% ========================================================================================================================================== %%%



if (obj.curStep > 0)                       
        obj.mDisp_history(obj.curStep,:) = obj.M_Disp';%'
        obj.mForc_history(obj.curStep,:) = obj.M_Forc';%'
end
