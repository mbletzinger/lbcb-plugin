classdef AlertsBox < handle
    properties
        list
        log = Logger('AlertsBox')
        dofl = {'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
    end
    methods
        function me = AlertsBox()
        end
        function add(me,text)
            if isempty(me.list)
                me.list = {text};
                return;
            end
            l = length(me.list);
            nl = cell(l+1,1);
            nl(1:l) = me.list(:);
            nl(l+1) = text;
            me.list = nl;
        end
        function remove(me,text)
            if isempty(me.list)
                return;
            end
            l = length(me.list);
            if l == 1 && strcmp(me.list{1},text)
                me.list = [];
                return;
            end
            nl = cell(l-1,1);
            ni = 1;
            for i = 1:l
                if strcmp(me.list{i},text) == false
                    nl(ni) = me.list{i};
                    ni = ni + 1;
                end
            end
            me.list = nl;
        end
        function text = fault2Text(me, fault, lbcb,dof)
            text = sprintf(' %s fault for LBCB %d %s',fault,lbcb,me.dofl{dof});
        end
        function setConnectionAlert(me,link)
            me.add(sprintf('%s connection is broken',link));
        end
        function clearConnectionAlert(me,link)
            me.remove(sprintf('%s connection is broken',link));
        end
        function setDeclineAlert(me)
            me.add('OM has declined a proposed command');
        end
        function clearDeclineAlert(me)
            me.remove('OM has declined a proposed command');
        end
    end
end