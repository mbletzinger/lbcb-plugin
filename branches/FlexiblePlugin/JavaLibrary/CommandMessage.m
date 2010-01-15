% =====================================================================================================================
% Class to access a response message
%
% Members:
%
% jcommand - Java Object containing response.
% isCompound - flag that indicates that the message contains mutiple
%  control points
%
% $LastChangedDate: 2009-07-02 18:04:20 -0500 (Thu, 02 Jul 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef CommandMessage < handle
    properties
        jcommand = {};
        isCompound = 0;
    end
    methods
        function me = CommandMessage(jcommand)
            me.jcommand = jcommand;
            if isa(jcommand,'org.nees.uiuc.simcor.transaction.SimCorCompoundMsg')
                me.isCompound = 1;
            end
        end
        function result = isOk(me)
            s = InitStates();
            mt = StateEnum(s.msgTypes);
            mt.setState(me.jcommand.getType());
            if mt.isState('COMMAND')
                result = 1;
            else
                result = 0;
            end
        end
        function [addresses, contents] = getContents(me)
            if me.isCompound
                jadrs = me.jcommand.getAddresses();
                size = jadrs.size();
                addresses = cell(size,1);
                contents = cell(size,1);
                for a = 0:size - 1
                    contents(a + 1) = me.jcommand.getContent(jadrs.get(a));
                    addresses(a + 1) = jadrs.get(a);
                end
            else
                addresses = me.jcommand.getAddress();
                contents = me.jcommand.getContent();
            end
        end
        function command = getCommand(me)
            command = char(me.jcommand.getCommand());
        end
    end
end