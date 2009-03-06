function [LbcbDisp State] = ExtTrans2Cartesian(Config,State,Params);


%Global increment at each iteration. Assume large values to go into while loop.
Meas2CalcDiff = [1 1 1 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while any(abs(Meas2CalcDiff) > Params.TOL)
	%Evaluate jacobain ================================================
	%Apply X perturbation and evaluate jacobian of 1st column
    PlatTmp = zeros(Config.NumSensors,3);
    LengthDiff = zeros(Config.NumSensors,1);
    for s=1:Config.NumSensors
        PlatTmp(s,:) = State.Plat(s,:) + [Config.Dx 0 0]';
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	State.J(:,1) = (-State.S + LengthDiffs)/Config.Dx;	
	
	%Apply Y perturbation and evaluate jacobian of 2nd column
    for s=1:Config.NumSensors
        PlatTmp(s,:) = State.Plat(s,:) + [Config.Dy 0 0]';
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	State.J(:,2) = (-State.S + LengthDiffs)/Config.Dy;	
	
	%Apply Rz perturbation and evaluate jacobian of 3rd column
    %State.S1p_offs
    %State.Platform_XYZ
    for s=1:Config.NumSensors
        PlatTmp(s,:) = rotateZ(State.Plat(s,:),State.Platform_XYZ,Config.Drz);
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
	State.J(:,3) = (-State.S + LengthDiffs)/Config.Drz;	
                            
    %Apply Rx perturbation and evaluate jacobian of 3rd column
    for s=1:Config.NumSensors
        PlatTmp(s,:) = rotateZ(State.Plat(s,:),State.Platform_XYZ,Config.Drx);
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
	State.J(:,3) = (-State.S + LengthDiffs)/Config.Drx;	

    %Difference between measured increment and increments from analytical iteration
	Meas2CalcDiff = inv(State.J)*(State.Readings*Config.Sensitivity - State.LengthInc);

	%Establish new coordinates
	State.Platform_Ctr = State.Platform_Ctr + Meas2CalcDiff;
    State.Platform_XYZ(1) = State.Platform_XYZ(1)+Meas2CalcDiff(1);
    State.Platform_XYZ(2) = State.Platform_XYZ(2)+Meas2CalcDiff(2);
	
	%Apply X and Y displacement
    for s=1:Config.NumSensors
        State.Plat(s,:) = State.Plat(s,:) + [Meas2CalcDiff(1) Meas2CalcDiff(2) 0]';
    end;
	
	%Apply rz rotation
    for s=1:Config.NumSensors
        State.Plat(s,:) = rotateZ(State.Plat(s,:),State.Platform_XYZ,Meas2CalcDiff(3));
    end;
    
    %Apply rx
    for s=1:Config.NumSensors
        State.Plat(s,:) = rotateZ(State.Plat(s,:),State.Platform_XYZ,Meas2CalcDiff(4));
    end;
	
	%Establish new string lengths
    for s=1:Config.NumSensors
        State.Lengths(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;

	State.LengthInc = State.Lengths - State.StartLengths;


end
External = State.Platform_Ctr - [Config.Off_SPCM(1) -Config.Off_SPCM(3) Config.Off_SPCM(5) Config.Off_SPCM(4)]';

% in LBCB coordinate system, 
External = [1 0 0 0; 0 -1 0 0; 0 0 1 0;0 0 0 1]*External;
External = Config.McTransform*External;
External = [External(1) 0 External(2) External(4) External(3) 0]';