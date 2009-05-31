% =====================================================================================================================
% Class containing degrees-of-freedom commands.
%
% Members:
%   data - Data for all twelve degrees of freedom.
%   dispDofs, forceDofs - Flags indicating which DOFs are being commanded.
%   node - The MDL node name.
%   cps - The control point suffix ex. LBCB1, ExternalSensors.
%  
%
% Last updated  $DATE$ 
% Author: $Author$
% =====================================================================================================================
classdef Target < handle
    properties
        data = DofData();
        dispDofs = zeros(6,1); % true if controlled dof displacement
        forceDofs = zeros(6,1);% true if controlled dof force
        dofLabels = {'x','y','z'};
        node = '';
        cps = '';
    end
    methods
        % Fills in the DOF data from a DofData structure
        function setCurrentPosition(me,dofData)
            me.data = dofData;
        end
        % Sets a displacement DOF
        function setDispDof(me,index,value)
            me.data.disp(index) = value;
            me.dispDofs(index) = 1;
        end
        % Sets a force DOF
        function setForceDof(me,index,value)
            me.data.force(index) = value;
            me.forceDofs(index) = 1;
        end
        % Exports the target data as an LBCB reading
        function reading = target2Reading(me)
            reading = lbcbReading();
            reading.lbcb = me.data();
        end
        % Converts target to message format ie.
        % x\tdisplacement\t1.00000e0-1
        function msg = createMsg(me)
            msg = '';
            first = 1;
            for i = 1:3
                if(me.dispDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',me.data.disp(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',me.data.disp(i)));
                    end
                end
            end
            for i = 4:6
                if(me.dispDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',me.data.disp(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',me.data.disp(i)));
                    end
                end
            end
            for i = 1:3
                if(me.forceDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'force',me.data.force(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i},'force',me.data.force(i)));
                    end
                end
            end
            for i = 4:6
                if(me.forceDofs(i))
                    if first
                        msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',me.data.force(i)));
                        first = 0;
                    else
                        msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',me.data.force(i)));
                    end
                end
            end
        end
    end
end