function init = initTgtData()
init.Disp        = zeros(6,1);               % Displacement at each step, Num_DOFx1
init.Forc        = zeros(6,1);               % Force at each step, Num_DOFx1
init.Cmd     = zeros(6,1);               % Flag set if force command