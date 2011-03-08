% =====================================================================================================================
% Class containing degrees-of-freedom commands.
%
% Members:
%   dispDofs, forceDofs - Flags indicating which DOFs are being commanded.
%  
%
% displacement DOFs are Dx Dy Dz Rx Ry Rz
% force DOFs are Fx Fy Fz Mx My Mz
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef Target < DofData
    properties
        dispDofs = zeros(6,1); % true for element d if controlled dof displacement
        forceDofs = zeros(6,1);% true for element d if controlled dof force
        m2d = Msg2DofData();
        dofLabels = {'x','y','z'};
    end
    methods
        function me = Target()
            me.dispDofs = zeros(6,1); % true if controlled dof displacement
            me.forceDofs = zeros(6,1);% true if controlled dof force
        end
        setDispDof(me,index,value) % set a displacement dof to value at the index
        setForceDof(me,index,value) % set a force dof to value at the index
        clearNonControlDofs(me) % clears any DOF that does not have a flag set in either dispDofs or forceDofs
        clone = clone(me)  % creates a duplicate target object;
        str = toString(me) % prints out all of the values in a string
        reading = target2Reading(me) % exports an LbcbReading object
        reading2Target(me,reading) % imports an LbcbReading object
        msg = createMsg(me) % Creates SimCor message contents.
        parse(me,msg,node) % Parses SimCor message contents -- not used
    end
end