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
    methods
        % Convert a message into an lbcb reading.
        function parse(me,msg,node)
            targets = me.m2d.parse(msg,node);
            me.lbcb = targets{1}.data;
            me.ed.force = me.lbcb.force;
        end
    end
end