function ret = Sendvar_LabView(obj,send_str)
% =====================================================================================================================
% Send data to remote site using LABVIEW protocol
%
%   obj     : A MDL_RF objects representing remote sites
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 8:40PM OSK
% =====================================================================================================================


send_str = [send_str 10];                                   % add new line character at the end
bufferSize = 512;                                           % send data
for i=1:floor(length(send_str)/bufferSize)
    fwrite(obj.Comm_obj,send_str((i-1)*bufferSize+1:i*bufferSize));
end
tmp = floor(length(send_str)/bufferSize);
fwrite(obj.Comm_obj,send_str(tmp*bufferSize+1:end));

stmp = sprintf('send to %13s ',obj.name);           % Initialize network log
stmp = sprintf('%s  %s',stmp, send_str(1:end-1));
LPLogger(stmp,2);
