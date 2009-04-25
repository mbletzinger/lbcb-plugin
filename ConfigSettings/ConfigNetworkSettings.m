function config = ConfigNetworkSettings()

config.simcorPort = 11999;
config.triggerPort =11997;
config.lbcbPort = 11998;
config.lbcbHost='';
config.timeout=60000; % Time in milliseconds for how long to wait for a message before declaring the link to be dead
config.multiplier=5; % timeout x multiplier > maximum OM ramp time.
config.inputFilesUseModelCoordinates = 0; % 1 = yes 0 = no
config.controlPointNodes= {'MDL-00-01','MDL-00-02','MDL-00-03'}; % Order has to match simcor messages