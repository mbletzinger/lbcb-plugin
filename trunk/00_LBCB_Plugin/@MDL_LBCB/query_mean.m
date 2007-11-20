function obj = query_mean(obj, varargin)

if obj.NoiseCompensation == 0
	NumSample = 1;
elseif obj.NoiseCompensation == 1
	NumSample = obj.NumSample;
end

if length(varargin) == 1 
	NumSample = varargin{1};		% override 
end

LBCBForc  = zeros(NumSample,6);
LBCBDisp  = zeros(NumSample,6);
%SJKIM Oct24-2007
Aux_Disp  = zeros(NumSample,5);

for i=1:NumSample

	obj = query(obj);
	
    LBCBForc(i,:) = obj.M_Forc';
    LBCBDisp(i,:) = obj.M_Disp';
    %SJKIM Oct24-2007
    Aux_Disp(i,:) = obj.M_AuxDisp_Raw';   %'
    if length(varargin) == 1		% if query_mean is called from step reduction, do not save
	else
		fid = fopen('Raw.txt','a');
		fprintf(fid,'%5.0f	',i);
		tmp_value_1=[];
		tmp_value_1=[Aux_Disp(i,:),LBCBDisp(i,:),LBCBForc(i,:)];
		for k=1:length (tmp_value_1)
			fprintf(fid,'%+12.7e	',tmp_value_1(k));
		end
		fprintf(fid,'\r\n');
		fclose(fid);
	end
end  
                             
obj.M_Forc    = mean(LBCBForc,1)';
obj.M_Disp    = mean(LBCBDisp,1)';

%SJKIM Oct01-2007
obj.M_AuxDisp_Raw = mean(Aux_Disp,1)'- obj.Aux_Config.InitialLength;  %'
obj.M_AuxDisp=[obj.M_AuxDisp_Raw(1,1) - obj.M_AuxDisp_Raw(4,1)        % X string (top-bottom)
               obj.M_AuxDisp_Raw(2,1)                                 % Left
               obj.M_AuxDisp_Raw(3,1)                                 % Right
               obj.M_AuxDisp_Raw(5,1)];                               % Front

if obj.DispMesurementSource == 0		    % do nothing
elseif obj.DispMesurementSource == 1		% convert stringpot readings to model coordinate system
	[obj.M_Disp obj.Aux_State] = Extmesu2Cartesian(obj.M_AuxDisp,obj.Aux_State,obj.Aux_Config);
end

if (obj.curStep > 0)                       
	obj.mDisp_history(obj.curStep,:) = obj.M_Disp';
	obj.mForc_history(obj.curStep,:) = obj.M_Forc';
end

if length(varargin) == 1		% if query_mean is called from step reduction, do not save
else
	fid = fopen('RawMean.txt','a');
	%SJKIM Oct24-2007
	fprintf(fid,'%5.0f	',obj.StepNos);
	tmp_value_2=[];
	tmp_value_2=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSample,:)'];  %'
	for k=1:length (tmp_value_2)
		fprintf(fid,'%+12.7e	',tmp_value_2(k));
	end
	fprintf(fid,'\r\n');
	fclose(fid);
end