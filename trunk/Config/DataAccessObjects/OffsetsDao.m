classdef OffsetsDao < Configuration
    properties
        offsets
        dt
    end
    methods
        function me = OffsetsDao()
            me = me@Configuration();
            me.filename = 'offsets.properties';
            me.dt = DataTypes(me);
        end
        function val = getOffset(name)
            val = me.dt.getDouble(name,0.0);
        end
        function setOffset(name,val)
            me.dt.setDouble(name,val);
        end
    end
end