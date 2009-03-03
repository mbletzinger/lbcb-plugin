function config = configGuiDefaults()
config.ItrElasticDeform = 1;		% 0 for no iteration, 1 for iteration
config.StepReduction = 1;		% 0 for no step reduction, 1 for step reduction when displacement increment is large
config.DispMeasurementSource = 1;	% 0 for LBCb, 1 for external mesurement
config.NoiseCompensation = 1;	% 0 for single reading, 1 for multiple reading and use average value

config.NumSample        = 10;					% number of samples to use to estimate average force and displacement 
config.DispTolerance    = [0.001 0.001 0.001 0.0005 0.0005 0.0005]';	% Displacement tolerance for displacement iteration stage. LBCB coordinate system.
config.DispIncMax       = [0.01  0.01  0.01  0.005  0.005  0.005 ]';	% Maximum displacement increment. 
config.Axis_X1	 = 1;			    % Default monitoring chart
config.Axis_X2	 = 1;			    % Default monitoring chart
config.Axis_X3	 = 1;			    % Default monitoring chart
config.Axis_Y1	 = 20;			    % Default monitoring chart
config.Axis_Y2	 = 2;			    % Default monitoring chart
config.Axis_Y3	 = 8;			    % Default monitoring chart

config.EnableMovingWin = 1;			    % Moving window display? 1 for yes, 0 for no
config.MovingWinWidth  = 50;			    % Moving window step with, 50
