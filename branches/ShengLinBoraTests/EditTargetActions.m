classdef EditTargetActions < handle
    properties
        targets
        dofHandles
    end
    methods
        function me = EditTargetActions(targets)
            me.targets = targets;
        end
        function init(me,handles)
            me.dofHandles = cell(6,4);
            
            me.dofHandles{1,1} = handles.dx1;
            me.dofHandles{2,1} = handles.dy1;
            me.dofHandles{3,1} = handles.dz1;
            me.dofHandles{4,1} = handles.rx1;
            me.dofHandles{5,1} = handles.ry1;
            me.dofHandles{6,1} = handles.rz1;
            
            me.dofHandles{1,2} = handles.fx1;
            me.dofHandles{2,2} = handles.fy1;
            me.dofHandles{3,2} = handles.fz1;
            me.dofHandles{4,2} = handles.mx1;
            me.dofHandles{5,2} = handles.my1;
            me.dofHandles{6,2} = handles.mz1;
            
            me.dofHandles{1,3} = handles.dx2;
            me.dofHandles{2,3} = handles.dy2;
            me.dofHandles{3,3} = handles.dz2;
            me.dofHandles{4,3} = handles.rx2;
            me.dofHandles{5,3} = handles.ry2;
            me.dofHandles{6,3} = handles.rz2;
            
            me.dofHandles{1,4} = handles.fx2;
            me.dofHandles{2,4} = handles.fy2;
            me.dofHandles{3,4} = handles.fz2;
            me.dofHandles{4,4} = handles.mx2;
            me.dofHandles{5,4} = handles.my2;
            me.dofHandles{6,4} = handles.mz2;
            for d = 1:6
                if me.targets{1}.dispDofs(d)
                    set(me.dofHandles{d,1},'String',sprintf('%f',me.targets{1}.disp(d)));
                else
                    set(me.dofHandles{d,1},'Enable','off');
                end
                if me.targets{1}.forceDofs(d)
                    set(me.dofHandles{d,2},'String',sprintf('%f',me.targets{1}.force(d)));
                else
                    set(me.dofHandles{d,2},'Enable','off');
                end
                if length(me.targets) == 2 &&  me.targets{2}.dispDofs(d)
                    set(me.dofHandles{d,3},'String',sprintf('%f',me.targets{2}.disp(d)));
                else
                    set(me.dofHandles{d,3},'Enable','off');
                end
                if length(me.targets) == 2 && me.targets{2}.forceDofs(d)
                    set(me.dofHandles{d,4},'String',sprintf('%f',me.targets{2}.force(d)));
                else
                    set(me.dofHandles{d,4},'Enable','off');
                end
            end
        end
        function setCommand(me,value,dof,row)
            switch row
                case 1
                    me.targets{1}.disp(dof) = value;
                case 2
                    me.targets{1}.force(dof) = value;
                case 3
                    me.targets{2}.disp(dof) = value;
                case 4
                    me.targets{2}.force(dof) = value;
            end
        end
    end
end