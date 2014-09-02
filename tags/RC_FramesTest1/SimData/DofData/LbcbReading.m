% =====================================================================================================================
% Class containing LBCB measurements.
%
% Members:
%   lbcb - Cartesian displacement and force data.
%   ed - Cartesian displacements and forces corrected for elastic
%   deformation.
%   m2d - class used to convert messages into reading data.
%   node - MDL label.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef LbcbReading < handle
    properties
        lbcb = [];
        ed = [];
        m2d = Msg2DofData();
        node = '';
        cdp = [];
        id = [];
        log = Logger('LbcbReading')

    end
    properties (Dependent = true)
        disp;
        force;
    end
    methods
        function me = LbcbReading()
            me.lbcb = DofData();
            me.ed = DofData();
            me.id = LbcbReading.newId();
        end
        % convenience function to get displacements based on whether the
        % application is using elastic deformation or not.  A set function
        % is not provided because the values must be set according to the
        % source
        function dof = get.disp(me)
            if isempty(me.cdp)
                dof = me.lbcb.disp;
                me.log.error(dbstack, 'CDP not set in LbcbReading');
                return;
            end
            if me.cdp.useEd()
                dof = me.ed.disp;
            else
                dof = me.lbcb.disp;
            end
        end
        function dof = get.force(me)
            dof = me.lbcb.force;
        end
         % Convert a message into an lbcb reading.
        function parse(me,msg,offsets)
            targets = me.m2d.parse(msg);
            me.lbcb.disp = targets{1}.disp - offsets;
            me.lbcb.force = targets{1}.force;
            me.ed.force = me.lbcb.force;
        end
        function clone = clone(me)
            clone = LbcbReading;
            clone.lbcb.disp = me.lbcb.disp;
            clone.lbcb.force = me.lbcb.force;
            clone.ed.disp = me.ed.disp;
            clone.ed.force = me.ed.force;
            clone.node = me.node;
            if isempty(me.cdp)
                me.log.error(dbstack,'CDP Not set');
                return;
            end
            clone.cdp = me.cdp;
        end
        function str = toString(me)
            str = sprintf('/lbcb%s\n\t',me.lbcb.toString());
            str = sprintf('%s/ed%s',str,me.ed.toString());
            str = sprintf('%s\n\t/id=%d',str,me.id);
        end
    end
    methods (Static, Access = private)
        function id = newId()
            global idCounter;
            if isempty(idCounter)
                idCounter = 1;
            else
                idCounter = idCounter + 1;
            end
            id = idCounter;
        end
    end

end
