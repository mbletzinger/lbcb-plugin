function p = MDL_AUX(vargin)
% =====================================================================================================================
% Constructor of auxiliary   module class
%       Input  : does not take any input
%       Return : return empty object
%
% Last updated on 7/19/2006, OSK
% =====================================================================================================================

p.name          = 'AUX';               		% Name of the auxiliary hardware module
p.ID            = 0;                      	% ID of this object, integer
p.URL           = '127.0.0.1:11999';		% URL of the remote site
p.protocol      = 'LabView1';           		% Protocol for communication
                                          	%   NTCP  : use NTCP protocol to connect NEESPop
                                          	%   LabView: use NTCP protocol without connecting NEESPop, compatible with labview plugin
p.Comm_obj      = {};                     	% communication object

p.Command     	= {'displacement' 'z' 3500};% Command to send out
p.CPname	    = 'AUX_CP';					% Control point name;

% -------------------------------------------------------------------------------------------------
% Default values of variables only used with NTCP mode
% -------------------------------------------------------------------------------------------------
p.CAM_Part    		= 'AUX';      			% This variable is only used with NTCP protocol
p.CAM_Role      	= 'Trigger';    		% This variable is only used with NTCP protocol
p.NTCP_SCREENLOG    = {1};                 	% ScreenLog: 0 for no screen log, 1 for screen log
p.NTCP_SECURE       = 0;                   	% 1 if secure client, 0 if not
p.MODEL             = 'UISIMCOR';          	% Model name
p.SIMULATION        = 'UIUC';              	% Simulation number
p.TransID           = '';                  	% Transaction ID
p.totStep 	    = 0;			% total number of steps;
p.curStep 	    = 0;			% total number of steps;
p.birth_step  	    = 0;			% first step of trigger

% -------------------------------------------------------------------------------------------------
% Command flags
% -------------------------------------------------------------------------------------------------
p.CMD.RQST_INITIALIZE       = char( 3);
p.CMD.RPLY_INITIALIZE_OK    = char( 4);
p.CMD.RQST_PUT_TARGET_DIS   = char(11);
p.CMD.RPLY_PUT_DATA         = char(16);
p.CMD.RQST_TEST_COMPLETE    = char(17);
p.CMD.RQST_OPENNETWORK      = char(51);
p.CMD.RQST_OPENNETWORK_OK   = char(52);
p.CMD.ACKNOWLEDGE           = char(99);

p.Initialized		= 0;	% Boolean to identify initialization
% Register the structure as class
p = class(p,'MDL_AUX');