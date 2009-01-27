%------------------------------------------------------------------------------------
% Configuration for external measurement
%------------------------------------------------------------------------------------

% Pin locations: LBCB coordinate system, inches. Origin of coordinate system should be platform center
Aux_Config.S1b = [4.375,39.5,201]';                 % base coordinate
Aux_Config.S1p = [93.5,38.125,200.75]';                      % platform coordinate
Aux_Config.S2b = [3.375,53,200.75]';             % base coordinate    
Aux_Config.S2p = [180.375,54.125,200.875]';                % platform coordinate

% Inital LBCB Location (all zeros if using local coordinates that are
% zeroed out in the Operations Manager).
        % If global coordinates are used
% Aux_Config.LBCB_Disp = [-0.177,-0.834,-0.134,-0.00216,0.00365,-0.00358]';
% Aux_Config.LBCB_Frc = [-27.3,-13.1,109.0,-49.6,-85.9,-13.5]';
        % If local coordinates are used
Aux_Config.LBCB_Disp = [0,0,0,0,0,0]';
Aux_Config.LBCB_Frc = [0,0,0,0,0,0]';

% Height of LBCB and Height of Roof Beam - to be used to amplify DX command
Aux_Config.LBCB_Ht=37;
Aux_Config.Roof_Ht=28.5;

% Pin Load Cell Location in LBCB Coordinates
Aux_Config.LC1 = [-43.25,0,28.25];
Aux_Config.LC2 = [43.75,0,28.25];

% Initial loads and lengths of String pots
% Order of gages is: ME_LC_1X, ME_LC_1Y, ME_LC_2X, ME_LC_2Y, ME_Left_SP, ME_Rt_SP
        % If global coordinates are used
% Aux_Config.InitialLength=[106.9 87.7 55.5 37.4 2.429 3.062]';
        % If local coordinates are used
Aux_Config.InitialLength=[0 0 0 0 0 0]';

% Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
Aux_Config.Off_SPCM = [ (0) 0 (0) (0) (0) 0]';

% Offset for motion center: LBCB coordinate system, X, Y, Z '
Aux_Config.Off_MCTR = [0, 0, 0]';
