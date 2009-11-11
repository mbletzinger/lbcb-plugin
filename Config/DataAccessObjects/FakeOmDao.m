% =====================================================================================================================
% Class which manages the fake OM properties
%
% Members:
%   cfg - a Configuration instance
%   scale1, scale2, offset1, offset2, derived1, and derived2 are all 
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef FakeOmDao < handle
    properties (Dependent = true)
        scale1
        scale2
        offset1
        offset2
        derived1
        derived2
        eScale
        eOffset
        eDerived
        convergeSteps
        convergeInc
    end
    properties
        dt;
        derivedOptions = {'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1',...
            'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1',...
            'Dx L2', 'Dy L2', 'Dz L2', 'Rx L2',  'Ry L2',  'Rz L2',...
            'Fx L2',   'Fy L2',   'Fz L2',   'Mx L2',   'My L2',   'Mz L2'};
    end
    methods
        function me = FakeOmDao(cfg)
            me.dt = DataTypes(cfg);
        end
        function result = get.derived1(me)
            result = me.dt.getStringVector('fake.om.derived1',[]);
        end
        function set.derived1(me,value)
            me.dt.setStringVector('fake.om.derived1',value);
        end
        
        function result = get.derived2(me)
            result = me.dt.getStringVector('fake.om.derived2',[]);
        end
        function set.derived2(me,value)
            me.dt.setStringVector('fake.om.derived2',value);
        end
        
        function result = get.scale1(me)
             result = me.dt.getDoubleVector('fake.om.scale1',ones(12,1));
        end
        function set.scale1(me,value)
            me.dt.setDoubleVector('fake.om.scale1',value);
        end
        
        function result = get.scale2(me)
             result = me.dt.getDoubleVector('fake.om.scale2',ones(12,1));
        end
        function set.scale2(me,value)
            me.dt.setDoubleVector('fake.om.scale2',value);
        end
        
        function result = get.offset1(me)
             result = me.dt.getDoubleVector('fake.om.offset1',ones(12,1));
        end
        function set.offset1(me,value)
            me.dt.setDoubleVector('fake.om.offset1',value);
        end
        
        function result = get.offset2(me)
             result = me.dt.getDoubleVector('fake.om.offset2',ones(12,1));
        end
        function set.offset2(me,value)
            me.dt.setDoubleVector('fake.om.offset2',value);
        end
        
        function result = get.eDerived(me)
            result = me.dt.getStringVector('fake.om.eDerived',[]);
        end
        function set.eDerived(me,value)
            me.dt.setStringVector('fake.om.eDerived',value);
        end
                
        function result = get.eScale(me)
             result = me.dt.getDoubleVector('fake.om.eScale',ones(12,1));
        end
        function set.eScale(me,value)
            me.dt.setDoubleVector('fake.om.eScale',value);
        end
                
        function result = get.eOffset(me)
             result = me.dt.getDoubleVector('fake.om.eOffset',ones(12,1));
        end
        function set.eOffset(me,value)
            me.dt.setDoubleVector('fake.om.eOffset',value);
        end
         function result = get.convergeSteps(me)
            result = me.dt.getInt('fake.om.converge.steps',0);
        end
        function set.convergeSteps(me,value)
             me.dt.setInt('fake.om.converge.steps',value);
       end
        function result = get.convergeInc(me)
             result = me.dt.getDouble('fake.om.converge.increment',ones(12,1));
        end
        function set.convergeInc(me,value)
             me.dt.setDouble('fake.om.converge.increment',value);
        end
       
    end
end