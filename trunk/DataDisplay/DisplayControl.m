classdef DisplayControl < handle
    properties
        isDisplayed = false;
        fig
        dmng
        dispFuncRef
        dispFact
        lbl = { 'Dx','Dy', 'Dz', 'Rx','Ry', 'Rz','Fx', 'Fy', 'Fz', 'Mx','My', 'Mz' }; 
    end
    methods
        function me = DisplayControl()
            me.isDisplayed = false;
        end
        function undisplayMe(me)
            if me.isDisplayed && isempty(me.fig) == false
                delete(me.fig);
            end 
            me.isDisplayed = false;
        end
    end
    methods (Abstract=true)
        displayMe(me)
    end
end