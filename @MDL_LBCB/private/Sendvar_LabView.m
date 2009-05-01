function ret = Sendvar_LabView(obj,send_str1,send_str2)
% =====================================================================================================================
% Send data to remote site using LABVIEW protocol
%
%   obj     : A MDL_RF objects representing remote sites
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 8:40PM OSK
% =====================================================================================================================

%fclose(obj.Comm_obj);
%connected = 0;
%numTrial  = 0;
%while connected == 0
%   try
%       fopen(obj.Comm_obj);
%       connected = 1;
%   catch
%       %outText = {sprintf('      - Connection failure to module: %s',SC.MDL_Name{MDL_Number})};
%       %OutputTXT(handles,outText,3);
%       %outText = {sprintf('        Retrying after 10 seconds ...   ')};
%       %OutputTXT(handles,outText,3);
%       pause(10);
%       numTrial = numTrial + 1;
%       if numTrial >= 10
%           outText = {sprintf(' * Connection failure. Check network status. Simulation terminated.')};
%           OutputTXT(handles,outText,3);
%           pause(10);
%       end
%   end
%end

% -----------------------------------------------------------------------------

send_str1 = [send_str1 10];                                   % add new line character at the end
bufferSize = 512;                                           % send data
for i=1:floor(length(send_str1)/bufferSize)
    fwrite(obj.Comm_obj_1,send_str1((i-1)*bufferSize+1:i*bufferSize));
end
tmp = floor(length(send_str1)/bufferSize);
fwrite(obj.Comm_obj_1,send_str1(tmp*bufferSize+1:end));

stmp = sprintf('send to LBCB1');           % Initialize network log
stmp = sprintf('%s  %s',stmp, send_str1(1:end-1));
LPLogger(stmp,2);

% By Sung Jig Kim, 04/30/2009
if isempty(strmatch(send_str2,'DummyExecute','exact'))==1
	send_str2 = [send_str2 10];                                   % add new line character at the end
	bufferSize = 512;                                           % send data
	for i=1:floor(length(send_str2)/bufferSize)
	    fwrite(obj.Comm_obj_2,send_str2((i-1)*bufferSize+1:i*bufferSize));
	end
	tmp = floor(length(send_str2)/bufferSize);
	fwrite(obj.Comm_obj_2,send_str2(tmp*bufferSize+1:end));
	
	stmp = sprintf('send to LBCB2');           % Initialize network log
	stmp = sprintf('%s  %s',stmp, send_str2(1:end-1));
	LPLogger(stmp,2);
end





