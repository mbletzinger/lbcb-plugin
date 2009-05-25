function obj = Trigger(obj)
% =====================================================================================================================
% Trigger camera
%
% Modified by   5/10/2009 Sung Jig Kim
% =====================================================================================================================

% Propose Command
for i=1:length(obj)
	obj(i).curStep= obj(i).curStep + 1;
	if obj(i).Initialized
		%---------------------------------------------------------------------------------------------------
        obj(i).TransID  = sprintf('trans%4d%02d%02d%02d%02d%4.3f',clock);       % Create transaction ID
		obj(i).CPname = 'MDL-AUX';
		send_str = sprintf('propose\t%s[ %04d]\t%s\t',obj(i).TransID ,obj(i).curStep, obj(i).CPname);
		tmpstr = '';
		for j=1:length(obj(i).Command)
			tmpstr = [tmpstr sprintf('%s\t',num2str(obj(i).Command{j}))];
		end
		send_str = [send_str tmpstr(1:end-1)];
		%---------------------------------------------------------------------------------------------------
		[obj(i).NetworkConnectionState]= Sendvar_LabView(obj(i), send_str);
	end
end

% Get Acknowledgement
for i=1:length(obj)
	if obj(i).NetworkConnectionState==1 & obj(i).Initialized==1
		[obj(i).NetworkConnectionState] = Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
	end
end

% Warning message for the network failure
for i=1:length(obj)
	if obj(i).NetworkConnectionState==0
		disp ( sprintf ('***Warning: %s is not triggered due to the network problem', obj(i).name));
		          disp ('            The data or picutre of the current step will not be stored.');
		          disp ('            Please save manually.');
	end
end