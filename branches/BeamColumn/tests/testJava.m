clear java
javaaddpath('00_LBCB_Plugin\JavaTcpLibrary\UiSimCorJava-0.0.1-SNAPSHOT.jar');
javaaddpath('00_LBCB_Plugin\JavaTcpLibrary\log4j-1.2.15.jar');
sender= org.nees.uiuc.simcor.CommandSender;
params = org.nees.uiuc.simcor.tcp.TcpParameters;
params.setRemoteHost('130.126.242.167');
params.setRemotePort(6342);
params.setTcpReadTimeout(30);
sender.setParams(params);