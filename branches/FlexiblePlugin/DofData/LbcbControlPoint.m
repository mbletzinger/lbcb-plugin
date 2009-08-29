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
        correctionDeltas = zeros(6,1);
    end
    methods
        function clone = clone(me)
            clone.command = me.command.clone();
            clone.correctionDeltas = me.correctionDeltas;
            clone.externalSensors = me.externalSensors;
        end
    end
end