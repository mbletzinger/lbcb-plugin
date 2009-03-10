function [LbcbDisp State] = ExtTrans2Cartesian(Config,State,Params)

%Global increment at each iteration. Assume large values to go into while loop.
Meas2CalcDiff = [1 1 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while any(abs(Meas2CalcDiff) > Params.TOL)
	%Evaluate jacobain ================================================
	%Apply X perturbation and evaluate jacobian of 1st column
    PlatTmp = zeros(Config.NumSensors,3);
    LengthDiff = zeros(Config.NumSensors,1);
    for s=1:Config.NumSensors
        PlatTmp(s,:) = State.Plat(s,:) + [Params.Dx 0 0];
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	State.Jacob(:,1) = (-State.Lengths + LengthDiff)/Params.Dx;
    %State.Jacob
    
	%Apply Z perturbation and evaluate jacobian of 2nd column
    for s=1:Config.NumSensors
        PlatTmp(s,:) = State.Plat(s,:) + [0 Params.Dz 0];
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	State.Jacob(:,2) = (-State.Lengths + LengthDiff)/Params.Dz;
    %State.Jacob
	
	%Apply Ry perturbation and evaluate jacobian of 3rd column
    %State.S1p_offs
    %State.Platform_XYZ
    for s=1:Config.NumSensors
        PlatTmp(s,:) = rotateY(State.Plat(s,:)',State.Platform_XYZ,Params.Ry); %DB- Need to create rotateY function
        LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    end;
	State.Jacob(:,3) = (-State.Lengths + LengthDiff)/Params.Ry;
    %State.Jacob
                            
    %Apply Rx perturbation and evaluate jacobian of 3rd column
    %for s=1:Config.NumSensors
    %    PlatTmp(s,:) = rotateZ(State.Plat(s,:),State.Platform_XYZ,Config.Drx);
    %    LengthDiff(s) = sqrt(sum((State.Base(s,:) - PlatTmp(s,:)).^2));
    %end;
	%State.Jacob(:,3) = (-State.Lengths + LengthDiffs)/Config.Drx;	

    %Difference between measured increment and increments from analytical
    %iteration
    State.LengthInc
	Meas2CalcDiff = inv(State.Jacob)*(State.Readings.*Config.Sensitivities - State.LengthInc);

	%Establish new coordinates
	State.Platform_Ctr = State.Platform_Ctr + Meas2CalcDiff;
    State.Platform_XYZ(1) = State.Platform_XYZ(1)+Meas2CalcDiff(1);
    State.Platform_XYZ(2) = State.Platform_XYZ(2)+Meas2CalcDiff(2);
	
	%Apply X and Y displacement
    for s=1:Config.NumSensors
        State.Plat(s,:) = State.Plat(s,:) + [Meas2CalcDiff(1) Meas2CalcDiff(2) 0];
    end;
	
	%Apply ry rotation
    for s=1:Config.NumSensors
        State.Plat(s,:) = rotateY(State.Plat(s,:)',State.Platform_XYZ,Meas2CalcDiff(3));
    end;
    
    %Apply rx
    %for s=1:Config.NumSensors
    %    State.Plat(s,:) = rotateZ(State.Plat(s,:),State.Platform_XYZ,Meas2CalcDiff(4));
    %end;
	
	%Establish new string lengths
    for s=1:Config.NumSensors
        State.Lengths(s,1) = sqrt(sum((State.Base(s,:) - State.Plat(s,:)).^2));
    end;
	State.LengthInc = State.Lengths - State.StartLengths;


end
External = State.Platform_Ctr - [Config.Off_SPCM(1) -Config.Off_SPCM(3) Config.Off_SPCM(5)]'; % DB - Need to adjust to our problem

% in LBCB coordinate system, 
External = eye(3)*External; % DB - Need to adjust to our problem
External = Config.McTransform*External;
External = [External(1) External(2) 0 0 External(3) 0]';
LbcbDisp = External;