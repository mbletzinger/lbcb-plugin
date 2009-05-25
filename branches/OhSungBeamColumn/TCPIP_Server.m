function TCPIP_handle = TCP_Server(MDL_Port)

% Open the sockets for remote sites
sock = tcpip_servsocket(MDL_Port);	 			% Open socket for Module i
if sock == -1
	disp(sprintf('Socket creation failure, Port # = %d', MDL_Port));
	TCPIP_handle = -1;
else
	% Listen for connection request from Modules
	disp(sprintf('Waiting for connection from client through port %d ...',MDL_Port));
	TCPIP_handle = -1;
	while TCPIP_handle < 0    
			TCPIP_handle = tcpip_listen(sock);
			pause(0.001);
	end
	disp(' ');
	disp(sprintf('A client is successfully connected.'));
end