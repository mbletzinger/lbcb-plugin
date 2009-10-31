% =====================================================================================================================
% Class containing degrees-of-freedom commands.
%
% Members:
%   dispDofs, forceDofs - Flags indicating which DOFs are being commanded.
%   node - The MDL node name.
%   cps - The control point suffix ex. LBCB1, ExternalSensors.
%  
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef Target < DofData
    properties
        dispDofs = zeros(6,1); % true if controlled dof displacement
        forceDofs = zeros(6,1);% true if controlled dof force
        dofLabels = {'x','y','z'};
        node = '';
        cps = '';
    end
    methods
        function me = Target()
            me.dispDofs = zeros(6,1); % true if controlled dof displacement
            me.forceDofs = zeros(6,1);% true if controlled dof force
        end
        setCurrentPosition(me,dofData)
        setDispDof(me,index,value)
        setForceDof(me,index,value)
        clearNonControlDofs(me)
        num = numDofs(me)
        clone = clone(me)
        str = toString(me)
        reading = target2Reading(me)
        msg = createMsg(me)
    end
end