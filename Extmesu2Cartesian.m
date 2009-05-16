function [External State] = Extmesu2Cartesian(ExtMesur,State,Config);

%Transformation matrix for coordinate conversion
T_LtoM = [ 1  0  0
	   0  0 -1
	   0  1  0];
	   
if State.StepNo == 1	%Initialize
	%Base pins with offset considered
	State.S1b_off = Config.S1b - T_LtoM * Config.Off_MCTR;
	State.S2b_off = Config.S2b - T_LtoM * Config.Off_MCTR;
	State.S3b_off = Config.S3b - T_LtoM * Config.Off_MCTR;
	
	%Platform pins with offset considered
	State.S1p_off = Config.S1p - T_LtoM * Config.Off_MCTR;
	State.S2p_off = Config.S2p - T_LtoM * Config.Off_MCTR;	     
	State.S3p_off = Config.S3p - T_LtoM * Config.Off_MCTR;	     	     
	
	%String lengths
	State.S =[sqrt(sum((State.S1b_off - State.S1p_off).^2))
	          sqrt(sum((State.S2b_off - State.S2p_off).^2))
	          sqrt(sum((State.S3b_off - State.S3p_off).^2))];
	
	%Save original reading from string pots
	State.So = State.S;
	
	%Global origin. Coordinate of platform center. Assume begins from 0,0,0.
	State.Platform_Ctr = [0 0 0]';
	
	% String length increment at each iteration
	State.Strn_Inc = [0 0 0]';
	
	% Jacobian
	State.J = zeros(3,3);
end

%ExtMesur = ExtMesur - State.So;
%Global increment at each iteration. Assume large values to go into while loop.
Glob_Inc = [1 1 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while any(abs(Glob_Inc) > Config.TOL)
	%Evaluate jacobain ================================================
	%Apply X perturbation and evaluate jacobian of 1st column
	S1p_tmp = State.S1p_off + [Config.dx 0 0]';
	S2p_tmp = State.S2p_off + [Config.dx 0 0]';
	S3p_tmp = State.S3p_off + [Config.dx 0 0]';

	State.J(:,1) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))])/Config.dx;	
	
	%Apply Y perturbation and evaluate jacobian of 2nd column
	S1p_tmp = State.S1p_off + [0 Config.dy 0]';
	S2p_tmp = State.S2p_off + [0 Config.dy 0]';
	S3p_tmp = State.S3p_off + [0 Config.dy 0]';

	State.J(:,2) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))])/Config.dy;	
	
	%Apply Rz perturbation and evaluate jacobian of 3rd column
	S1p_tmp = rotateZ(State.S1p_off,State.Platform_Ctr,Config.drz);
	S2p_tmp = rotateZ(State.S2p_off,State.Platform_Ctr,Config.drz);
	S3p_tmp = rotateZ(State.S3p_off,State.Platform_Ctr,Config.drz);

	State.J(:,3) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))])/Config.drz;	
	
	%Difference between measured increment and increments from analytical iteration
	Glob_Inc = inv(State.J)*(ExtMesur.*Config.sensitivity - State.Strn_Inc);
	
	%Establish new coordinates
	State.Platform_Ctr = State.Platform_Ctr + Glob_Inc; 
	
	%Apply X and Y displacement
	State.S1p_off = State.S1p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
	State.S2p_off = State.S2p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
	State.S3p_off = State.S3p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
	
	%Apply rotation
	State.S1p_off = rotateZ(State.S1p_off,State.Platform_Ctr,Glob_Inc(3));
	State.S2p_off = rotateZ(State.S2p_off,State.Platform_Ctr,Glob_Inc(3));
	State.S3p_off = rotateZ(State.S3p_off,State.Platform_Ctr,Glob_Inc(3));
	
	%Establish new string lengths
	State.S =[sqrt(sum((State.S1b_off - State.S1p_off).^2))
	          sqrt(sum((State.S2b_off - State.S2p_off).^2))
	          sqrt(sum((State.S3b_off - State.S3p_off).^2))];

	State.Strn_Inc = State.S - State.So;
end
External = Config.T*State.Platform_Ctr - [Config.Off_SPCM(1) -Config.Off_SPCM(3) Config.Off_SPCM(5)]';

% in LBCB coordinate system, 
External = [-External(2) 0 -External(1) 0 External(3) 0]';