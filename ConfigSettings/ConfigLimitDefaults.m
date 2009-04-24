function config = ConfigLimitDefaults()

config.CheckDisp = 1;                   % 1 for check, 0 for ignore     
config.CheckDispInc = 1;                % 1 for check, 0 for ignore     
config.CheckForce = 0;                  % 1 for check, 0 for ignore     

config.Lbcb1.Disp = zeros(2,6);
config.Lbcb1.Force = zeros(2,6);
config.Lbcb1.StepInc = zeros(1,6);

config.Lbcb2.Disp = zeros(2,6);
config.Lbcb2.Force = zeros(2,6);
config.Lbcb2.StepInc = zeros(1,6);

config.Lbcb1.Disp(1,:)      = [-3 -3  -2  -0.2 -0.2 -0.2 ]';   % Displacement limit
config.Lbcb1.Disp(2,:)      = [ 3  3   2   0.2  0.2  0.2 ]';   % Displacement limit
config.Lbcb1.StepInc        = [ 1  1   1   0.05 0.05 0.05]';   % Displacement increment limit
config.Lbcb1.Force(1,:)     = [-1000 -1000 -1500 -2000 -2000 -2000]'; % Force limit
config.Lbcb1.Force(1,:)     = [ 1000  1000  1500  2000  2000  2000]'; % Force limit '

config.Lbcb2.Disp(1,:)      = [-3 -3  -2  -0.2 -0.2 -0.2 ]';   % Displacement limit
config.Lbcb2.Disp(2,:)      = [ 3  3   2   0.2  0.2  0.2 ]';   % Displacement limit
config.Lbcb2.StepInc        = [ 1  1   1   0.05 0.05 0.05]';   % Displacement increment limit
config.Lbcb2.Force(1,:)     = [-1000 -1000 -1500 -2000 -2000 -2000]'; % Force limit
config.Lbcb2.Force(2,:)     = [ 1000  1000  1500  2000  2000  2000]'; % Force limit '
