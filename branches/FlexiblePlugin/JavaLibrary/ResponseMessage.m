% =====================================================================================================================
% Class to access a response message
%
% Members:
%
% jresponse - Java Object containing response.
% isCompound - flag that indicates that the message contains mutiple
%  control points
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef ResponseMessage < handle
    properties
        jresponse = {};
        isCompound = 0;
    end
    methods
        function me = ResponseMessage(jresponse)
            me.jresponse = jresponse;
         if isa(jresponse,'org.nees.uiuc.simcor.transaction.SimCorCompoundMsg')
             me.isCompound = 1;
         end
        end
        function result = isOk(me)
            s = InitStates();
            mt = StateEnum(s.msgTypes);
            mt.setState(me.jresponse.getType());
            if mt.isState('OK_RESPONSE')
                result = 1;
            else
                result = 0;
            end
        end
        function [addresses, contents] = getContents(me)
            if me.isCompound
                adrs = me.jresponse.getAddresses();
                size = adrs.size();
                addresses = cell(size,1);
                contents = cell(size,1);
                for a = 0:size - 1
                    contents(a) = me.jresponse.getContents(adrs.get(a));
                    addresses(a) = adrs.get(a);
                end
            else
                addresses = me.jresponse.getAddress();
                contents = me.jresponse.getContent();
            end
        end
    end
end