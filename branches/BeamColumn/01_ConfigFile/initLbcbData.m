function init = initLbcbData()

init.LbcbDispReadings= zeros(6,1);               % LBCB displacement readings at each step, Num_DOFx1
init.AuxDisp         = zeros(3,1);               % Measured auxiliary displacement at each step
init.MeasForc        = zeros(6,1);               % Measured force at each step, Num_DOFx1
init.AvgLbcbDispReadings= zeros(6,1);               % LBCB displacement readings at each step, Num_DOFx1
init.AvgMeasForc        = zeros(6,1);               % Measured force at each step, Num_DOFx1
init.MeasDisp        = zeros(6,1);               % Measured displacement used for each step, Num_DOFx1

init.PrevDispCmd      = zeros(6,1);                       % Previous step's target displacement, Num_DOFx1
init.DispCmd        = zeros(6,1);                       % Target displacement, Num_DOFx1
init.PrevForcCmd      = zeros(6,1);                       % Previous step's target displacement, Num_DOFx1
init.ForcCmd        = zeros(6,1);                       % Target displacement, Num_DOFx1
