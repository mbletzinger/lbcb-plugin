function State = ResetExtTransState(State,NumSensors)

State.StartLengths   = State.Lengths;
State.Platform_Ctr   = zeros(NumSensors,1);
State.Jacob          = zeros(NumSensors,NumSensors);
State.LengthInc      = zeros(NumSensors,1);
State.Platform_XYZ   = zeros(NumSensors,1);
