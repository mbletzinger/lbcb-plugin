function ret = Send_Parmatlab(tcp_handle, send_str)

send_str = [send_str 10];                                   % add new line character at the end
bufferSize = 1024;                                          % send data
for i=1:floor(length(send_str)/bufferSize)
    tcpip_write(tcp_handle,send_str((i-1)*bufferSize+1:i*bufferSize));
end
tmp = floor(length(send_str)/bufferSize);
tcpip_write(tcp_handle,send_str(tmp*bufferSize+1:end));

stmp = sprintf('%s', send_str(1:end-1));
DataLogger(stmp,2);