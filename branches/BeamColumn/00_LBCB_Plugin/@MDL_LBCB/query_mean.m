function obj = query_mean(obj, varargin)

if obj.NoiseCompensation == 0
	NumSample = 1;
elseif obj.NoiseCompensation == 1
	NumSample = obj.NumSample;
end

if varargin{1} == 3 
	NumSample = 1;		% override 
end

% query the measured data
LBCBForc  = zeros(NumSample,6);
LBCBDisp  = zeros(NumSample,6);
Aux_Disp  = zeros(NumSample,5);

for i=1:NumSample
	obj = query(obj);
    LBCBForc(i,:) = obj.M_Forc';
    LBCBDisp(i,:) = obj.M_Disp';
    %SJKIM Oct24-2007
    Aux_Disp(i,:) = obj.M_AuxDisp_Raw';   %'
    if varargin{1} == 3 		% if query_mean is called from step reduction, do not save
	else
		SaveFileName=sprintf('Raw_%s.txt',obj.TestDate_Str); SaveData=[];
		SaveData=[Aux_Disp(i,:),LBCBDisp(i,:),LBCBForc(i,:)];
		% save data
		SaveSimulationData (SaveFileName,i,SaveData,1);
	end
end  
                             
obj.M_Forc    = mean(LBCBForc,1)';
obj.M_Disp    = mean(LBCBDisp,1)';

% For Update Monitor
obj.LBCB_MDispl = obj.M_Disp;


%SJKIM Oct01-2007
obj.M_AuxDisp_Raw = mean(Aux_Disp,1)'- obj.Aux_Config.InitialLength;  %'
obj.M_AuxDisp=[obj.M_AuxDisp_Raw(1,1) - obj.M_AuxDisp_Raw(4,1)        % X string (top-bottom)
               obj.M_AuxDisp_Raw(2,1)                                 % Left
               obj.M_AuxDisp_Raw(3,1)                                 % Right
               obj.M_AuxDisp_Raw(5,1)];                               % Front


if obj.DispMesurementSource == 0		    % do nothing
elseif obj.DispMesurementSource == 1		% convert stringpot readings to model coordinate system
	% convert stringpot readings to model coordinate system
	[obj.M_Disp obj.Aux_State] = Extmesu2Cartesian(obj.M_AuxDisp,obj.Aux_State,obj.Aux_Config);
end



if (obj.curStep > 0)                       
	obj.mDisp_history(obj.curStep,:) = obj.M_Disp';
	obj.mForc_history(obj.curStep,:) = obj.M_Forc';
end

if obj.StepNos > 0
	obj.Model_mDisp_history(obj.StepNos,:) = obj.M_Disp';
	obj.Model_mForc_history(obj.StepNos,:) = obj.M_Forc';
end


if varargin{1} == 3 		% if query_mean is called from step reduction, do not save
	% RawMeanData for Step Reduction
	SaveFileName=sprintf('RawMean_SRStep_%s.txt',obj.TestDate_Str); SaveData=[];
	SaveData=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSample,:)'];  %'
	% save data
	SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
else
	% RawMeanData for Elastic Deformation iteration
	SaveFileName=sprintf('RawMean_EDStep_%s.txt',obj.TestDate_Str); SaveData=[];
	SaveData=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSample,:)'];  %'
	% save data
	SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
	
	obj.SimCorStepData=SaveData;
end

% RawMeanData for All Step
SaveFileName=sprintf('RawMean_AllStep_%s.txt',obj.TestDate_Str); SaveData=[];
SaveData=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSample,:)'];  %'
% save data
SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
