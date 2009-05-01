function ret = Sendvar_LabView(obj,varargin)
% =====================================================================================================================
% Send data to remote site using LABVIEW protocol
%
%   obj     : A MDL_RF objects representing remote sites
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 8:40PM OSK
% =====================================================================================================================


send_str1 = [varargin{1} 10];                                   % add new line character at the end
bufferSize = 512;                                           % send data
for i=1:floor(length(send_str1)/bufferSize)
    fwrite(obj.Comm_obj_1,send_str1((i-1)*bufferSize+1:i*bufferSize));
end
tmp = floor(length(send_str1)/bufferSize);
fwrite(obj.Comm_obj_1,send_str1(tmp*bufferSize+1:end));

stmp = sprintf('send to OperationManager');           % Initialize network log
stmp = sprintf('%s  %s',stmp, send_str1(1:end-1));
LPLogger(stmp,2);







