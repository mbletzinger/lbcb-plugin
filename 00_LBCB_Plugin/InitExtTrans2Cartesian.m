function State = InitExtTrans2Cartesian(Config,State);
%Transformation matrix for coordinate conversion
T_LtoM = Config.TransformLbcb2Model;
for s=1:Config.NumSensors
    %Base pins with offset considered
    State.Base(s,:) = Config.Base(s,:) - T_LtoM * Config.Off_MCTR;

    %Platform pins with offset considered
    State.Plat(s,:) = Config.Plat(s,:) - T_LtoM * Config.Off_MCTR;

    %String lengths
    State.Lengths(s) = sqrt(sum((State.Base(s,:) - State.Plat(s,:)).^2));
end
State = ResetExtTransState(State, Config.NumSensors);
