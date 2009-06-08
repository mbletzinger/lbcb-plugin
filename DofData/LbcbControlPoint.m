% =====================================================================================================================
% Class containing a command and response for one LBCB.
%
% Members:
%   response - LbcbReading instance.
%   command - Target instance. 
%   externalSensors - Sensor Readings for the LBCB.
%  
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef LbcbControlPoint < handle
    properties
        response = LbcbReading;
        command = Target;
        externalSensors = [];
    end
    methods
    end
end