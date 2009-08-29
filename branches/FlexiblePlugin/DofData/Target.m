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
        % Fills in the DOF data from a DofData structure
        function setCurrentPosition(me,dofData)
            me.disp = dofData.disp;
            me.force = dofData.force;
        end
        % Sets a displacement DOF
        function setDispDof(me,index,value)
            me.disp(index) = value;
            me.dispDofs(index) = 1;
        end
        % Sets a force DOF
        function setForceDof(me,index,value)
            me.force(index) = value;
            me.forceDofs(index) = 1;
        end
        function clearNonControlDofs(me)
            for i=1:6
                if me.dispDofs(i) == 0
                    me.disp(i) = 0;
                end
                if me.forceDofs(i) == 0
                    me.forces(i) = 0;
                end
            end
        end
        function clone = clone(me)
            clone = Target;
            clone.dispDofs = me.dispDofs;
            clone.forceDofs = me.forceDofs;
            clone.disp = me.disp;
            clone.force = me.force;
            clone.node = me.node;
            clone.cps = me.cps;
        end
        % Exports the target data as an LBCB reading
        function reading = target2Reading(me)
            reading = lbcbReading();
            reading.lbcb.disp = me.disp;
            reading.lbcb.force = me.force;
        end
        % Converts target to message format ie.
        % x\tdisplacement\t1.00000e0-1
        function msg = createMsg(me)
            msg = '';
            first = 1;
            for i = 1:3
                if(me.dispDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',me.disp(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',me.disp(i)));
                    end
                end
            end
            for i = 4:6
                if(me.dispDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',me.disp(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',me.disp(i)));
                    end
                end
            end
            for i = 1:3
                if(me.forceDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'force',me.force(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i},'force',me.force(i)));
                    end
                end
            end
            for i = 4:6
                if(me.forceDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',me.force(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',me.force(i)));
                    end
                end
            end
        end
    end
end