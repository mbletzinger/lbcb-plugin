function config = NetworkSettings()

config.localPort = 11999;
config.inputFilesUseModelCoordinates = 0; % 1 = yes 0 = no
config.controlPointNodes= {'MDL-00-01','MDL-00-02','MDL-00-03'}; % Order has to match simcor messages