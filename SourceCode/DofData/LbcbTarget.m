classdef lbcbTarget < handle
    properties
        target = dofData();
        dispDofs = zeros(6,1); % true if controlled dof displacement
        forceDofs = zeros(6,1);% true if controlled dof force
        dofLabels = {'x','y','z'};
        node = '';
    end
    methods
        function setCurrentPosition(me,dofData)
            me.target = dofData;
        end
        function setDispDof(me,index,value)
            me.target.disp(index) = value;
            me.dispDofs(index) = 1;
        end
        function setForceDof(me,index,value)
            me.target.force(index) = value;
            me.forceDofs(index) = 1;
        end
        function reading = target2Reading(me)
            reading = lbcbReading();
            reading.lbcb = me.target();
        end
        function msg = createMsg(me)
            msg = '';
            for i = 1:3
                if(me.dispDofs(i))
                    msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',me.target.disp(i)));
                end
            end
            for i = 4:6
                if(me.dispDofs(i))
                    msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',me.target.disp(i)));
                end
            end
            for i = 1:3
                if(me.forceDofs(i))
                    msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'force',me.target.force(i)));
                end
            end
            for i = 4:6
                if(me.forceDofs(i))
                    msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',me.target.force(i)));
                end
            end
        end
    end
end