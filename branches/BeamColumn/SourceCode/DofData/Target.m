classdef Target < handle
    properties
        data = dofData();
        dispDofs = zeros(6,1); % true if controlled dof displacement
        forceDofs = zeros(6,1);% true if controlled dof force
        dofLabels = {'x','y','z'};
        cps = '';
    end
    methods
        function setCurrentPosition(me,dofData)
            me.data = dofData;
        end
        function setDispDof(me,index,value)
            me.data.disp(index) = value;
            me.dispDofs(index) = 1;
        end
        function setForceDof(me,index,value)
            me.data.force(index) = value;
            me.forceDofs(index) = 1;
        end
        function reading = target2Reading(me)
            reading = lbcbReading();
            reading.lbcb = me.data();
        end
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