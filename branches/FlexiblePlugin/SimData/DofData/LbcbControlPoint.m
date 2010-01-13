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
        response = [];
        command = [];
        externalSensors = [];
        correctionDeltas = zeros(6,1);
        log = Logger('LbcbControlPoint')
    end
    methods
        function me = LbcbControlPoint()
            me.response = LbcbReading;
            me.command = Target;
        end
        function clone = clone(me)
            clone = LbcbControlPoint;
            clone.command = me.command.clone();
            clone.response = me.response.clone();
            clone.correctionDeltas = me.correctionDeltas;
            clone.externalSensors = me.externalSensors;
        end
        function str = toString(me)
            str = sprintf('/command=%s',me.command.toString());
            str = sprintf('%s\n\t/response=%s\n\t/externalSensors',str,me.response.toString());
            for s = 1: length(me.externalSensors)
                str = sprintf('%s,%f',str,me.externalSensors(s));
            end
            str = sprintf('%s\n\t/deltas',str);
            labels = {'dx' 'dy' 'dz' 'rx' 'ry' 'rz'};
            for v = 1:length(me.correctionDeltas)
                str = sprintf('%s/%s=%f',str,labels{v},me.correctionDeltas(v));
            end
        end
        function [ disp dDofs force fDofs] = cmdData(me)
            disp = me.command.disp;
            dDofs = me.command.dispDofs;
            force = me.command.force;
            fDofs = me.command.forceDofs;
        end
        function [ disp force] = respData(me)
            disp = me.response.disp;
            force = me.response.force;
            
        end
%         function set.command(me,cmd)
%             if iscell(cmd)
%                 disp('Single cell array assigned to command'); 
%                 dbstop;
%             end
%             me.command = cmd;
%         end
    end
end