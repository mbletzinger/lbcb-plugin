function config = ConfigSimulationParameters()
config.cfgStepSize = .05 % Step size used to determine the number of substeps in a target change.
config.DispTolerance    = [0.001 0.001 0.001 0.0005 0.0005 0.0005]';	% Displacement tolerance for displacement iteration stage. 
                                                                                                                               %LBCB coordinate system.
                                                                                                                               