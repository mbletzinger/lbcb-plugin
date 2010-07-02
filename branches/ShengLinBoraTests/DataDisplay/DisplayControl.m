classdef DisplayControl < handle
    properties
        isDisplayed = false;
        fig
    end
    methods
        function me = DisplayControl()
            me.isDisplayed = false;
        end
        function displayMe2(me)
            me.isDisplayed = true;
        end
        function undisplayMe(me)
            if me.isDisplayed
                delete(me.fig);
            end 
            me.isDisplayed = false;
        end
    end
end