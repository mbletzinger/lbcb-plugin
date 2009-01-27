%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function query_mean.m takes NumSample samples of all         %
% measurements, takes the average of the measurments,          %
% converts them to a model space coordinate system,            %
% records raw and averaged data to file, and returns           %
% values to the parent program                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function obj = query_mean(obj, varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the number of samples that will be averaged together to make 
% one data point
% if obj.NoiseCompensation == 0
% 	NumSample = 1;
% elseif obj.NoiseCompensation == 1
% 	NumSample = obj.NumSample;
% end
NumSample=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize size of measurment matricies
LBCBForc  = zeros(NumSample,6);
LBCBDisp  = zeros(NumSample,6);
Aux_Disp  = zeros(NumSample,6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get NumSample measurements to average together
for i=1:NumSample
    % Get measurements from the LBCB Operations Manager
	obj = query(obj);
	
    % Pull measurements out of the obj structure
    LBCBForc(i,:) = obj.M_Forc';
    LBCBDisp(i,:) = obj.M_Disp';
    Aux_Disp(i,:) = obj.M_AuxDisp_Raw';

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find average of the samples
obj.M_Forc    = mean(LBCBForc,1)';
obj.M_Disp    = mean(LBCBDisp,1)';

% Set a variable equal to raw LBCB measurments for use in main program
obj.M_LBCB_Forc=obj.M_Forc;
obj.M_LBCB_Disp=obj.M_Disp;

% Zero out the string pots by subtracting inital positions.  Initial
% positions are contained in Ext_Measure_Config.m
obj.M_AuxDisp = mean(Aux_Disp,1)'- obj.Aux_Config.InitialLength;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert auxillary measurements to a cartesian coordinate system
if obj.DispMesurementSource == 0		    % do nothing
elseif obj.DispMesurementSource == 1		% convert to model coord
	[obj.M_Disp obj.M_Forc obj.Aux_State] = ...
        Extmesu2Cartesian(obj.M_AuxDisp,obj.M_Disp,obj.M_Forc,...
        obj.Aux_State,obj.Aux_Config);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save raw data to file
% cd('..');
% cd('Output Files');
fid = fopen('Raw.txt','a');

tmp1 = clock; 			% format to the time output of NTCP mode (for consistency)
tmp2 = sprintf('%.6f',(tmp1(end)-floor(tmp1(end))));
tmp1(end) = floor(tmp1(end));
stamp = sprintf('%s%s \t',datestr(tmp1,0),tmp2(2:end));

fprintf(fid,'%s %5.0f	',stamp,obj.curStep);
tmp_value_2=[];
tmp_value_2=[obj.M_AuxDisp;obj.M_Forc;obj.M_Disp;LBCBDisp(NumSample,:)'];
for k=1:length (tmp_value_2)
    fprintf(fid,'%+12.7e	',tmp_value_2(k));
end
fprintf(fid,'\r\n');
fclose(fid);
% cd('..');
% cd('Support Files');
