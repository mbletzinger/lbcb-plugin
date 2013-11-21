classdef OffsetsDao < Configuration
    properties
        offsets
        dt
        lbcbNames
    end
    methods
        function me = OffsetsDao()
            me = me@Configuration();
            me.filename = 'offsets.properties';
            me.dt = DataTypes(me);
            me.lbcbNames = {'LBCB1.Dx','LBCB1.Dy','LBCB1.Dz','LBCB1.Rx','LBCB1.Ry','LBCB1.Rz', ...
                'LBCB2.Dx','LBCB2.Dy','LBCB2.Dz','LBCB2.Rx','LBCB2.Ry','LBCB2.Rz'};
        end
        function val = getOffset(me,name)
            val = me.dt.getDouble(name,0.0);
        end
        function setOffset(me,name,val)
            me.dt.setDouble(name,val);
        end
    end
end
