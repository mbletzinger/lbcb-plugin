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
        lbcb = DofData();
        ed = DofData();
        m2d = Msg2DofData();
        node = '';
    end
    properties (Dependent = true)
        disp;
        force;
    end
    methods
        % convenience function to get displacements based on whether the
        % application is using elastic deformation or not.  A set function
        % is not provided because the values must be set according to the
        % source
        function dof = get.disp(me)
            if LbcbReading.useEd()
                dof = me.ed.disp;
            else
                dof = me.lbcb.disp;
            end
        end
        function dof = get.force(me)
            dof = me.lbcb.force;
        end
         % Convert a message into an lbcb reading.
        function parse(me,msg,node)
            targets = me.m2d.parse(msg,node);
            me.lbcb.disp = targets{1}.disp;
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
        end
        function str = toString(me)
            str = sprintf('/lbcb%s\n\t',me.lbcb.toString());
            str = sprintf('%s/ed%s',str,me.ed.toString());
        end
    end
    methods (Static)
        function yes = useEd()
            cfg = SimulationState.getCfg();
            ocfg = OmConfigDao(cfg);
            yes = ocfg.doEdCalculations;
        end
    end
end