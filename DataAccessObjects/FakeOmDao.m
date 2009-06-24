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
    end
    properties
        cfg = Configuration();
        su = StringListUtils();
        derivedOptions = {'Dx L1', 'Dy L1', 'Dz L1', 'Rx L1',  'Ry L1',  'Rz L1',...
            'Fx L1',   'Fy L1',   'Fz L1',   'Mx L1',   'My L1',   'Mz L1',...
            'Dx L2', 'Dy L2', 'Dz L2', 'Rx L2',  'Ry L2',  'Rz L2',...
            'Fx L2',   'Fy L2',   'Fz L2',   'Mx L2',   'My L2',   'Mz L2'};
    end
    methods
        function me = FakeOmDao(cfg)
            me.cfg = cfg;
        end
        function result = get.derived1(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.derived1');
              if isempty(resultSL)
                  result = [];
                  return;
              end
              result = me.su.sl2ca(resultSL);
        end
        function set.derived1(me,value)
            valS = me.su.ca2sl(value);
              me.cfg.props.setPropertyList('fake.om.derived1',valS);
        end
        
        function result = get.derived2(me)
            resultSL = me.cfg.props.getPropertyList('fake.om.derived2');
            if isempty(resultSL)
                result = [];
                return;
            end
            result = me.su.sl2ca(resultSL);
        end
        function set.derived2(me,value)
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList('fake.om.derived2',valS);
        end
        
        function result = get.scale1(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.scale1');
              if isempty(resultSL)
                  result = ones(12,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.scale1(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('fake.om.scale1',valS);
        end
        
        function result = get.scale2(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.scale2');
              if isempty(resultSL)
                  result = ones(12,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.scale2(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('fake.om.scale2',valS);
        end
        
        function result = get.offset1(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.offset1');
              if isempty(resultSL)
                  result = zeros(12,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.offset1(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('fake.om.offset1',valS);
        end
        
        function result = get.offset2(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.offset2');
              if isempty(resultSL)
                  result = zeros(12,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.offset2(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('fake.om.offset2',valS);
        end
        
        function result = get.eDerived(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.eDerived');
              if isempty(resultSL)
                  result = [];
                  return;
              end
              result = me.su.sl2ca(resultSL);
        end
        function set.eDerived(me,value)
            valS = me.su.ca2sl(value);
              me.cfg.props.setPropertyList('fake.om.eDerived',valS);
        end
                
        function result = get.eScale(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.eScale');
              if isempty(resultSL)
                  result = ones(12,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.eScale(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('fake.om.eScale',valS);
        end
                
        function result = get.eOffset(me)
              resultSL = me.cfg.props.getPropertyList('fake.om.eOffset');
              if isempty(resultSL)
                  result = zeros(12,1);
                  return;
              end
              result = me.su.sl2da(resultSL);
        end
        function set.eOffset(me,value)
            valS = me.su.da2sl(value);
              me.cfg.props.setPropertyList('fake.om.eOffset',valS);
        end
        
    end
end