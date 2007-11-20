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
    State.S4b_off = Config.S4b - T_LtoM * Config.Off_MCTR;
	
	%Platform pins with offset considered
	State.S1p_off = Config.S1p - T_LtoM * Config.Off_MCTR;
	State.S2p_off = Config.S2p - T_LtoM * Config.Off_MCTR;	     
	State.S3p_off = Config.S3p - T_LtoM * Config.Off_MCTR;
    State.S4p_off = Config.S4p - T_LtoM * Config.Off_MCTR;
	
	%String lengths
	State.S =[sqrt(sum((State.S1b_off - State.S1p_off).^2))
	          sqrt(sum((State.S2b_off - State.S2p_off).^2))
	          sqrt(sum((State.S3b_off - State.S3p_off).^2))
              sqrt(sum((State.S4b_off - State.S4p_off).^2))];
	
	%Save original reading from string pots
	State.So = State.S;
	
	%Global origin in terms of elastic DOFS (x,z,ry,rx).  Assume begins from 0,0,0,0.
	State.Platform_Ctr = [0 0 0 0]';
    
    %Global origin in terms of x,y,z (model system)
    State.Platform_XYZ = [0,0,0]';
	
	% String length increment at each iteration
	State.Strn_Inc = [0 0 0 0]';
	
	% Jacobian
	State.J = zeros(4,4);
	
end


%Global increment at each iteration. Assume large values to go into while loop.
Glob_Inc = [1 1 1 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while any(abs(Glob_Inc) > Config.TOL)
	%Evaluate jacobain ================================================
	%Apply X perturbation and evaluate jacobian of 1st column
	S1p_tmp = State.S1p_off + [Config.dx 0 0]';
	S2p_tmp = State.S2p_off + [Config.dx 0 0]';
	S3p_tmp = State.S3p_off + [Config.dx 0 0]';
    S4p_tmp = State.S4p_off + [Config.dx 0 0]';

	State.J(:,1) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))
                                sqrt(sum((State.S4b_off - S4p_tmp).^2))])/Config.dx;	
	
	%Apply Y perturbation and evaluate jacobian of 2nd column
	S1p_tmp = State.S1p_off + [0 Config.dy 0]';
	S2p_tmp = State.S2p_off + [0 Config.dy 0]';
	S3p_tmp = State.S3p_off + [0 Config.dy 0]';
    S4p_tmp = State.S4p_off + [0 Config.dy 0]';

	State.J(:,2) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))
                                sqrt(sum((State.S4b_off - S4p_tmp).^2))])/Config.dy;	
	
	%Apply Rz perturbation and evaluate jacobian of 3rd column
    %State.S1p_off
    %State.Platform_XYZ
	S1p_tmp = rotateZ(State.S1p_off,State.Platform_XYZ,Config.drz);
	S2p_tmp = rotateZ(State.S2p_off,State.Platform_XYZ,Config.drz);
	S3p_tmp = rotateZ(State.S3p_off,State.Platform_XYZ,Config.drz);
    S4p_tmp = rotateZ(State.S4p_off,State.Platform_XYZ,Config.drz);

	State.J(:,3) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))
                                sqrt(sum((State.S4b_off - S4p_tmp).^2))])/Config.drz;	
                            
    %Apply Rx perturbation and evaluate jacobian of 3rd column
	S1p_tmp = rotateX(State.S1p_off,State.Platform_XYZ,Config.drx);
	S2p_tmp = rotateX(State.S2p_off,State.Platform_XYZ,Config.drx);
	S3p_tmp = rotateX(State.S3p_off,State.Platform_XYZ,Config.drx);
    S4p_tmp = rotateX(State.S4p_off,State.Platform_XYZ,Config.drx);

	State.J(:,4) = (-State.S + [sqrt(sum((State.S1b_off - S1p_tmp).^2))
	                            sqrt(sum((State.S2b_off - S2p_tmp).^2))
	                            sqrt(sum((State.S3b_off - S3p_tmp).^2))
                                sqrt(sum((State.S4b_off - S4p_tmp).^2))])/Config.drz;
	
	%Difference between measured increment and increments from analytical iteration
	Glob_Inc = inv(State.J)*(ExtMesur.*Config.sensitivity - State.Strn_Inc);

	%Establish new coordinates
	State.Platform_Ctr = State.Platform_Ctr + Glob_Inc;
    State.Platform_XYZ(1) = State.Platform_XYZ(1)+Glob_Inc(1);
    State.Platform_XYZ(2) = State.Platform_XYZ(2)+Glob_Inc(2);
	
	%Apply X and Y displacement
	State.S1p_off = State.S1p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
	State.S2p_off = State.S2p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
	State.S3p_off = State.S3p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
    State.S4p_off = State.S4p_off + [Glob_Inc(1) Glob_Inc(2) 0]';
	
	%Apply rz rotation
	State.S1p_off = rotateZ(State.S1p_off,State.Platform_XYZ,Glob_Inc(3));
	State.S2p_off = rotateZ(State.S2p_off,State.Platform_XYZ,Glob_Inc(3));
	State.S3p_off = rotateZ(State.S3p_off,State.Platform_XYZ,Glob_Inc(3));
    State.S4p_off = rotateZ(State.S4p_off,State.Platform_XYZ,Glob_Inc(3));
    
    %Apply rx
    State.S1p_off = rotateX(State.S1p_off,State.Platform_XYZ,Glob_Inc(4));
	State.S2p_off = rotateX(State.S2p_off,State.Platform_XYZ,Glob_Inc(4));
	State.S3p_off = rotateX(State.S3p_off,State.Platform_XYZ,Glob_Inc(4));
    State.S4p_off = rotateX(State.S4p_off,State.Platform_XYZ,Glob_Inc(4));
	
	%Establish new string lengths
	State.S =[sqrt(sum((State.S1b_off - State.S1p_off).^2))
	          sqrt(sum((State.S2b_off - State.S2p_off).^2))
	          sqrt(sum((State.S3b_off - State.S3p_off).^2))
              sqrt(sum((State.S4b_off - State.S4p_off).^2))];

	State.Strn_Inc = State.S - State.So;


end
External = State.Platform_Ctr - [Config.Off_SPCM(1) -Config.Off_SPCM(3) Config.Off_SPCM(5) Config.Off_SPCM(4)]';

% in LBCB coordinate system, 
External = [1 0 0 0; 0 -1 0 0; 0 0 1 0;0 0 0 1]*External;
External = Config.T*External;
External = [External(1) 0 External(2) External(4) External(3) 0]';