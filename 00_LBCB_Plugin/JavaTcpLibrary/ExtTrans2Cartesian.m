function LbcbDisp = ExtTrans2Cartesian(state,params,readings)

%Global increment at each iteration. Assume large values to go into while loop.
Meas2CalcDiff = [1 1 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while any(abs(Meas2CalcDiff) > params.TOL)
	%Evaluate jacobain ================================================
	%Apply X perturbation and evaluate jacobian of 1st column
    PlatTmp = zeros(state.numSensors,3);
    LengthDiff = zeros(state.numSensors,1);
    for s=1:state.numSensors
        PlatTmp(s,:) = state.plat(s,:) + [params.pertD(1) 0 0];
        LengthDiff(s) = sqrt(sum((state.base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	state.jacob(:,1) = (-state.lengths + LengthDiff)/params.pertD(1);
    
    
	%Apply Z perturbation and evaluate jacobian of 2nd column
    for s=1:state.numSensors
        PlatTmp(s,:) = state.plat(s,:) + [0 params.pertD(2) 0];
        LengthDiff(s) = sqrt(sum((state.base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	state.jacob(:,2) = (-state.lengths + LengthDiff)/params.pertD(2);
	
	%Apply Ry perturbation and evaluate jacobian of 3rd column
    for s=1:state.numSensors
        PlatTmp(s,:) = rotateY(state.plat(s,:)',state.platformCtrCalc,params.pertD(3));
        LengthDiff(s) = sqrt(sum((state.base(s,:) - PlatTmp(s,:)).^2));
    end;
    
	state.jacob(:,3) = (-state.lengths + LengthDiff)/params.pertD(3);

    %Difference between measured increment and increments from analytical
    %iteration    
    
	Meas2CalcDiff = inv(state.jacob)*(readings.lengths - state.lengthDiff);
    
    
    %Establish new coordinates
    state.platformCtrMeas = state.platformCtrMeas + Meas2CalcDiff;
    state.platformCtrCalc(1) = state.platformCtrCalc(1)+Meas2CalcDiff(1);
    state.platformCtrCalc(2) = state.platformCtrCalc(2)+Meas2CalcDiff(2);
    %Apply X and Y displacement

    for s=1:state.numSensors
        state.plat(s,:) = state.plat(s,:) + [Meas2CalcDiff(1) Meas2CalcDiff(2) 0];
    end;

    %Apply ry rotation
    for s=1:state.numSensors
        state.plat(s,:) = rotateY(state.plat(s,:)',state.platformCtrCalc,Meas2CalcDiff(3));
    end;


    %Establish new string lengths
    for s=1:state.numSensors
        state.lengths(s,1) = sqrt(sum((state.base(s,:) - state.plat(s,:)).^2));
    end;
    state.lengthDiff = state.lengths - state.startLengths;

end
offsets = state.geometry.motionCenter2SpecimanOffset;
External = state.platformCtrMeas - [offsets(1) -offsets(3) offsets(5)]'; % DB - Need to adjust to our problem

% in LBCB coordinate system,
External = eye(3)*External; % DB - Need to adjust to our problem
External = state.geometry.lbcb2SpecimanXfrm*External;
External = [External(1) External(2) 0 0 External(3) 0]';
LbcbDisp = External;