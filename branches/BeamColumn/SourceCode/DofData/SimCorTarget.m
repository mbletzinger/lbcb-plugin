classdef SimCorTarget < handle
    properties
        target = dofData();
        dispDofs = zeros(6,1); % true if controlled dof displacement
        forceDofs = zeros(6,1);% true if controlled dof force
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
    end
end