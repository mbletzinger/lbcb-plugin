classdef Coord < handle
    properties
        label;
        img;
        mtrx;
    end
    methods
        function me = Coord(l,im,m)
            me.label = l;
            me.img = im;
            me.mtrx = m;
        end
    end
end