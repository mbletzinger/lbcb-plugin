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
classdef ModelControlPoint < handle
    properties
        response = [];
        command = [];
        address = [];

    end
    methods
        function me = ModelControlPoint()
            me.response = Target;
            me.command = Target;
        end
        function clone = clone(me)
            clone = ModelControlPoint;
            clone.command = me.command.clone();
            clone.response = me.response.clone();
        end
        function str = toString(me)
            str = sprintf('/addr=%s',me.address);
            str = sprintf('%s/command=%s',str,me.command.toString());
            str = sprintf('%s\n\t/response=%s',str,me.response.toString());
        end
        function parse(me,msg,address)
            targets = me.m2d.parse(msg,address);
            me.command = targets{1};
            me.address = address;
        end
    end
end