function obj = query_mean(obj, varargin)

NumSamples = 1;
if obj.Gui.NoiseCompensation == 1
	NumSamples = obj.NumSamples;
end

if varargin{1} == 3 
	NumSamples = 1;		% override 
end

% query the measured data
LBCBForc.L1  = zeros(NumSamples,6);
LBCBDisp.L1  = zeros(NumSamples,6);
LBCBForc.L2  = zeros(NumSamples,6);
LBCBDisp.L2  = zeros(NumSamples,6);
Aux_Disp  = zeros(NumSamples,obj.ExtTrans.Config.AllNumSensors);

for i=1:NumSamples
	obj = query(obj); % Get control point from operations manager
    LBCBForc.L1(i,:) = obj.Raw.Lbcb1.Forc';
    LBCBDisp.L1(i,:) = obj.Raw.Lbcb1.Disp';
    LBCBForc.L2(i,:) = obj.Raw.Lbcb2.Forc';
    LBCBDisp.L2(i,:) = obj.Raw.Lbcb2.Disp';
    %SJKIM Oct24-2007
    Aux_Disp(i,:) = obj.Raw.ExtTrans';   %'
    if varargin{1} == 3 		% if query_mean is called from step reduction, do not save
	else
% 		SaveFileName=sprintf('Raw_%s.txt',obj.TestDate_Str); 
%         SaveData=[];
% 		SaveData=[Aux_Disp(i,:),LBCBDisp.L1(i,:),LBCBForc.L1(i,:),LBCBDisp.L2(i,:),LBCBForc.L2(i,:)];
% 		% save data
% 		SaveSimulationData (SaveFileName,i,SaveData,1);
	end
end  
                             
obj.Avg.Lbcb1.Forc    = mean(LBCBForc.L1,1)';
obj.Meas.Lbcb1.Forc    = mean(LBCBForc.L1,1)';
obj.Avg.Lbcb1.Disp    = mean(LBCBDisp.L1,1)';
obj.Avg.Lbcb2.Forc    = mean(LBCBForc.L2,1)';
obj.Meas.Lbcb2.Forc    = mean(LBCBForc.L2,1)';
obj.Avg.Lbcb2.Disp    = mean(LBCBDisp.L2,1)';


%SJKIM Oct01-2007
obj.Avg.ExtTrans = mean(Aux_Disp,1)'- obj.ExtTrans.Config.InitialLength;  %'
% obj.M_AuxDisp=[obj.Lbcb1.ExternalTransducers(1,1) - obj.Lbcb1.ExternalTransducers(4,1)        % X string (top-bottom)
%                obj.Lbcb1.ExternalTransducers(2,1)                                 % Left
%                obj.Lbcb1.ExternalTransducers(3,1)                                 % Right
%                obj.Lbcb1.ExternalTransducers(5,1)];                               % Front

% Split External Transducer Measurements
idxBounds = obj.ExtTrans.Config.Lbcb1.IdxBounds;
ExtTransLbcb1 = obj.Avg.ExtTrans(idxBounds(1):idxBounds(2));
idxBounds = obj.ExtTrans.Config.Lbcb2.IdxBounds;
ExtTransLbcb2 = obj.Avg.ExtTrans(idxBounds(1):idxBounds(2));

obj.Meas.Lbcb1.Forc    = obj.Avg.Lbcb1.Forc;
obj.Meas.Lbcb2.Forc    = obj.Avg.Lbcb1.Forc;

if obj.Gui.DispMeasurementSource == 0		    % do nothing
    obj.Meas.Lbcb1.Disp    = obj.Avg.Lbcb1.Disp;
    obj.Meas.Lbcb2.Disp    = obj.Avg.Lbcb1.Disp;
elseif obj.Gui.DispMeasurementSource == 1		% convert stringpot readings to model coordinate system
	[obj.Meas.Lbcb1.Disp obj.ElastDef.Lbcb1] = ExtTrans2Cartesian(obj.ExtTrans.Config.Lbcb1,...
        obj.ElastDef.Lbcb1,obj.ExtTrans.Config.Params,ExtTransLbcb1);
	[obj.Meas.Lbcb2.Disp obj.ElastDef.Lbcb1] = ExtTrans2Cartesian(obj.ExtTrans.Config.Lbcb2,...
        obj.ElastDef.Lbcb2,obj.ExtTrans.Config.Params,ExtTransLbcb2);
end

if (obj.curStep > 0)                       
	obj.Lbcb1.mDisp_history(obj.curStep,:) = obj.Meas.Lbcb1.Disp';
	obj.Lbcb1.mForc_history(obj.curStep,:) = obj.Meas.Lbcb1.Forc';
	obj.Lbcb2.mDisp_history(obj.curStep,:) = obj.Meas.Lbcb2.Disp';
	obj.Lbcb2.mForc_history(obj.curStep,:) = obj.Meas.Lbcb2.Forc';
end

if obj.StepNos > 0
	obj.Lbcb1.Model_mDisp_history(obj.StepNos,:) = obj.Lbcb1.MeasDisp';
	obj.Lbcb1.Model_mForc_history(obj.StepNos,:) = obj.Lbcb1.AvgMeasForc';
	obj.Lbcb2.Model_mDisp_history(obj.StepNos,:) = obj.Lbcb2.MeasDisp';
	obj.Lbcb2.Model_mForc_history(obj.StepNos,:) = obj.Lbcb2.AvgMeasForc';
end


% if varargin{1} == 3 		% if query_mean is called from step reduction, do not save
% 	% RawMeanData for Step Reduction
% 	SaveFileName=sprintf('RawMean_SRStep_%s.txt',obj.TestDate_Str); SaveData=[];
% 	SaveData=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSamples,:)'];  %'
% 	% save data
% 	SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
% else
% 	% RawMeanData for Elastic Deformation iteration
% 	SaveFileName=sprintf('RawMean_EDStep_%s.txt',obj.TestDate_Str); SaveData=[];
% 	SaveData=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSamples,:)'];  %'
% 	% save data
% 	SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
% 	
% 	obj.SimCorStepData=SaveData;
% end
% 
% % RawMeanData for All Step
% SaveFileName=sprintf('RawMean_AllStep_%s.txt',obj.TestDate_Str); SaveData=[];
% SaveData=[obj.ExtTrans.AvgMeas;obj.Lbcb1.AvgMeasForc;obj.Lbcb1.MeasDisp;LBCBDisp.L1(NumSamples,:)'...
%     obj.Lbcb2.AvgMeasForc;obj.Lbcb2.MeasDisp;LBCBDisp.L2(NumSamples,:)'];  %'
% % save data
% SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
