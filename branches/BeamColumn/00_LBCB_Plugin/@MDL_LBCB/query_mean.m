function obj = query_mean(obj, varargin)

if obj.Gui.NoiseCompensation == 0
	NumSample = 1;
elseif obj.Gui.NoiseCompensation == 1
	NumSample = obj.NumSample;
end

if varargin{1} == 3 
	NumSample = 1;		% override 
end

% query the measured data
LBCBForc.L1  = zeros(NumSample,6);
LBCBDisp.L1  = zeros(NumSample,6);
LBCBForc.L2  = zeros(NumSample,6);
LBCBDisp.L2  = zeros(NumSample,6);
Aux_Disp  = zeros(NumSample,p.ExtTrans.Config.AllNumSensors);

for i=1:NumSample
	obj = query(obj); % Get control point from operations manager
    LBCBForc.L1(i,:) = obj.Lbcb1.MeasForc';
    LBCBDisp.L1(i,:) = obj.Lbcb1.LbcbDispReadings';
    LBCBForc.L2(i,:) = obj.Lbcb2.MeasForc';
    LBCBDisp.L2(i,:) = obj.Lbcb2.LbcbDispReadings';
    %SJKIM Oct24-2007
    Aux_Disp(i,:) = obj.ExtTrans.State.Meas';   %'
    if varargin{1} == 3 		% if query_mean is called from step reduction, do not save
	else
		SaveFileName=sprintf('Raw_%s.txt',obj.TestDate_Str); 
        SaveData=[];
		SaveData=[Aux_Disp(i,:),LBCBDisp.L1(i,:),LBCBForc.L1(i,:),LBCBDisp.L2(i,:),LBCBForc.L2(i,:)];
		% save data
		SaveSimulationData (SaveFileName,i,SaveData,1);
	end
end  
                             
obj.Lbcb1.AvgMeasForc    = mean(LBCBForc.L1,1)';
obj.Lbcb1.AvgLbcbDispReadings    = mean(LBCBDisp.L1,1)';
obj.Lbcb2.AvgMeasForc    = mean(LBCBForc.L2,1)';
obj.Lbcb2.AvgLbcbDispReadings    = mean(LBCBDisp.L2,1)';


%SJKIM Oct01-2007
obj.ExtTrans.State.AvgMeas = mean(Aux_Disp,1)'- obj.ExtTrans.Config.InitialLength;  %'
% obj.M_AuxDisp=[obj.Lbcb1.ExternalTransducers(1,1) - obj.Lbcb1.ExternalTransducers(4,1)        % X string (top-bottom)
%                obj.Lbcb1.ExternalTransducers(2,1)                                 % Left
%                obj.Lbcb1.ExternalTransducers(3,1)                                 % Right
%                obj.Lbcb1.ExternalTransducers(5,1)];                               % Front

% Split External Transducer Measurements
idxBounds = obj.ExtTrans.Config.Lbcb1.IdxBounds;
obj.ExtTrans.State.Lbcb1.Readings = obj.ExtTrans.State.AvgMeas(idxBounds(1),idxBounds(2));
idxBounds = obj.ExtTrans.Config.Lbcb2.IdxBounds;
obj.ExtTrans.State.Lbcb2.Readings = obj.ExtTrans.State.AvgMeas(idxBounds(1),idxBounds(2));

if obj.Gui.DispMeasurementSource == 0		    % do nothing
elseif obj.Gui.DispMeasurementSource == 1		% convert stringpot readings to model coordinate system
	[obj.Lbcb1.MeasDisp obj.ExtTrans.Lbcb1.State] = ExtTrans2Cartesian(obj.ExtTrans.Lbcb1.Config,...
        obj.ExtTrans.Lbcb1.State,obj.ExtTrans.Config.Params);
	[obj.Lbcb2.MeasDisp obj.ExtTrans.Lbcb2.State] = ExtTrans2Cartesian(obj.ExtTrans.Lbcb2.Config,...
        obj.ExtTrans.Lbcb2.State,obj.ExtTrans.Config.Params);
end

if (obj.curStep > 0)                       
	obj.Lbcb1.mDisp_history(obj.curStep,:) = obj.Lbcb1.MeasDisp';
	obj.Lbcb1.mForc_history(obj.curStep,:) = obj.Lbcb1.AvgMeasForc';
	obj.Lbcb2.mDisp_history(obj.curStep,:) = obj.Lbcb2.MeasDisp';
	obj.Lbcb2.mForc_history(obj.curStep,:) = obj.Lbcb2.AvgMeasForc';
end

if obj.StepNos > 0
	obj.Lbcb1.Model_mDisp_history(obj.StepNos,:) = obj.Lbcb1.MeasDisp';
	obj.Lbcb1.Model_mForc_history(obj.StepNos,:) = obj.Lbcb1.AvgMeasForc';
	obj.Lbcb2.Model_mDisp_history(obj.StepNos,:) = obj.Lbcb2.MeasDisp';
	obj.Lbcb2.Model_mForc_history(obj.StepNos,:) = obj.Lbcb2.AvgMeasForc';
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
SaveData=[obj.ExtTrans.AvgMeas;obj.Lbcb1.AvgMeasForc;obj.Lbcb1.MeasDisp;LBCBDisp.L1(NumSample,:)'...
    obj.Lbcb2.AvgMeasForc;obj.Lbcb2.MeasDisp;LBCBDisp.L2(NumSample,:)'];  %'
% save data
SaveSimulationData (SaveFileName,obj.StepNos,SaveData,1);
