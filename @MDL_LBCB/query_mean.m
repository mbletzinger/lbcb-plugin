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
Aux_Disp1  = zeros(NumSample,3);
Aux_Disp2  = zeros(NumSample,3);

for i=1:NumSample
	% Request data
	obj = query(obj);
	 % by Sung Jig Kim, 05/02/2009
	if obj.NetworkConnectionState
		LBCBForc1(i,:) = [obj.M_Forc1'   ];%'
		LBCBDisp1(i,:) = [obj.M_Disp1'   ];%'
		Aux_Disp1(i,:) = [obj.M_AuxDisp1'];%'
		
		LBCBForc2(i,:) = [obj.M_Forc2'   ];%'
		LBCBDisp2(i,:) = [obj.M_Disp2'   ];%'
		Aux_Disp2(i,:) = [obj.M_AuxDisp2'];%'
	else
		% When the network connection is failed
		break;
	end
end  

%%%%%%
% Debugging, SJKIM
% tmp_1=obj.NetworkConnectionState;
% disp (sprintf ('Connection State: %02d', tmp_1));
% tmp_data=Aux_Disp1;
% Str1='External Measurement 1: ';
% for Hussam=1:length(tmp_data)
% 	Str1=sprintf ('%s   %+16.8e',Str1, tmp_data(Hussam));
% end
% disp(Str1);
% 
% tmp_data=Aux_Disp2;
% Str1='External Measurement 2: ';
% for Hussam=1:length(tmp_data)
% 	Str1=sprintf ('%s   %+16.8e',Str1, tmp_data(Hussam));
% end
% disp(Str1);
%%%%


if obj.NetworkConnectionState   
                          
	obj.M_Forc1    = mean(LBCBForc1,1)';%'
	obj.M_Disp1    = mean(LBCBDisp1,1)';%'
	obj.M_AuxDisp1 = mean(Aux_Disp1,1)'-obj.Aux_Config1.InitialLength;%'
	OM_Disp1       = obj.M_Disp1;
    
	obj.M_Forc2    = mean(LBCBForc2,1)';%'
	obj.M_Disp2    = mean(LBCBDisp2,1)';%'
	obj.M_AuxDisp2 = mean(Aux_Disp2,1)'-obj.Aux_Config2.InitialLength;%'
	OM_Disp2       = obj.M_Disp2;
	
	if obj.DispMesurementSource == 0                % do nothing
	
	elseif obj.DispMesurementSource == 1            % convert stringpot readings to model coordinate system
	        [obj.M_Disp1 obj.Aux_State1] = Extmesu2Cartesian(obj.M_AuxDisp1,obj.Aux_State1,obj.Aux_Config1);
	        [obj.M_Disp2 obj.Aux_State2] = Extmesu2Cartesian(obj.M_AuxDisp2,obj.Aux_State2,obj.Aux_Config2);
    end
	
    obj.M_Disp1 = obj.M_Disp1 .* [-1 1 1 1 -1 1]';   % DJB: Take care of sign issues.
    
	obj.M_Disp = [obj.M_Disp1;obj.M_Disp2]; % Measured displacement, LBCB1 coordiante, LBCB2 coordinate
	obj.M_Forc = [obj.M_Forc1;obj.M_Forc2];
	
	
	%%% debugging code =================================================================================================================================
	
	%Test_Config;
	%obj.M_Disp = obj.M_Disp / cmd_scale_rubber;
	%obj.M_Forc = obj.M_Forc / cmd_scale_rubber;
	
	
	
	%%% ========================================================================================================================================== %%%
	
	
	
	if (obj.curStep > 0)                       
	        obj.mDisp_history(obj.curStep,:) = obj.M_Disp';%'
	        obj.mForc_history(obj.curStep,:) = obj.M_Forc';%'
	end
	
	% Hussam, you need some scripts here to save your data,  by Sung Jig Kim, 05/02/2009
	% 1. RawMeanData for Step Reduction
	% 2. RawMeanData for Elastic Deformation iteration
	% 3. RawMeanData for All Step
    
	SaveFileName = sprintf('LBCB1_RawMean.txt'); SaveData = [];
    SaveData = [obj.M_AuxDisp1;obj.M_Disp1;OM_Disp1;obj.M_Forc1;obj.T_Disp(1:6);obj.Disp_T_Model(1:6)];
    SaveSimulationData(SaveFileName,obj.StepNo,SaveData);
    
	SaveFileName = sprintf('LBCB2_RawMean.txt'); SaveData = [];
    SaveData = [obj.M_AuxDisp2;obj.M_Disp2;OM_Disp2;obj.M_Forc2;obj.T_Disp(7:12);obj.Disp_T_Model(7:12)];
    SaveSimulationData(SaveFileName,obj.StepNo,SaveData);
    %%%%%%
%     % Debugging, SJKIM
%     tmp_data=obj.M_Disp;
%     Str1='Measured Displacement: ';
%     for Hussam=1:length(tmp_data)
%         Str1=sprintf ('%s   %.8f',Str1, tmp_data(Hussam));
%     end
%     disp(Str1);
%     %%%%

end