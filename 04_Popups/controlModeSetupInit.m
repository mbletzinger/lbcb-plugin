function init = controlModeSetupInit()
init.DisplacementMeasurement.Lbcb = 0;
init.DisplacementMeasurement.ExternalTransducers = 1;
init.ControlMode.DisplacementControl = 1;
init.ControlMode.MixedModeControlPsd = 0;
init.ControlMode.MixedModeControlStatic = 0;
init.ForceControlDof=1;
init.LowerBound = 300;
init.KsecEvaluationIterator = 5;
init.KsecFactor = 0.7;
init.MixedModeControlStatic.Fx = 0;
init.MixedModeControlStatic.Fy = 0;
init.MixedModeControlStatic.Fz = 0;
init.MixedModeControlStatic.Mx = 0;
init.MixedModeControlStatic.My = 0;
init.MixedModeControlStatic.Mz = 0;
init.MaxIterations = 20;

