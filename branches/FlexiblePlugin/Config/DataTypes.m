% =====================================================================================================================
% Class which manages the operations manager configuration data
%
% Members:
%   cfg - a Configuration instance
%   numLbcbs, sensorNames, apply2Lbcb are all
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef DataTypes < handle
    properties
        dofL = {'dx' 'dy' 'dz' 'rx' 'ry' 'rz'};
        cfg;
        su = StringListUtils();
    end
    methods
        function me = DataTypes(cfg)
            me.cfg = cfg;
        end
        function result = getInt(me,key,default)
            str = char(me.cfg.props.getProperty(key));
            if isempty(str)
                result = default;
                return;
            end
            result = sscanf(str,'%d');
        end
        function setInt(me,key,value)
            me.cfg.props.setProperty(key,sprintf('%d',value));
        end
        function result = getDouble(me,key,default)
            str = char(me.cfg.props.getProperty(key));
            if isempty(str)
                result = default;
                return;
            end
            result = sscanf(str,'%f');
        end
        function setDouble(me,key,value)
            me.cfg.props.setProperty(key,sprintf('%f',value));
        end
        function result = getBool(me,key,default)
            str = char(me.cfg.props.getProperty(key));
            if isempty(str)
                result = default;
                return;
            end
            result = sscanf(str,'%d');
        end
        function setBool(me,key,value)
            me.cfg.props.setProperty(key,sprintf('%d',value));
        end
        function result = getString(me,key,default)
            str = char(me.cfg.props.getProperty(key));
            if isempty(str)
                result = default;
                return;
            end
            result = char(str);
        end
        function setString(me,key,value)
            me.cfg.props.setProperty(key,value);
        end
        
        function result = getStringVector(me,key,default)
            resultSL = me.cfg.props.getPropertyList(key);
            if isempty(resultSL)
                result = default;
                return;
            end
            result = me.su.sl2ca(resultSL);
        end
        function setStringVector(me,key,value)
            if isempty(value)
                return
            end
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList(key,valS);
        end
        function result = getDoubleVector(me,key,default)
            resultSL = me.cfg.props.getPropertyList(key);
            if isempty(resultSL)
                result = default;
                return;
            end
            result = me.su.sl2da(resultSL);
        end
        function setDoubleVector(me,key,value)
            if isempty(value)
                return
            end
            valS = me.su.da2sl(value);
            me.cfg.props.setPropertyList(key,valS);
        end
        function result = getIntVector(me,key,default)
            resultSL = me.cfg.props.getPropertyList(key);
            if isempty(resultSL)
                result = default;
                return;
            end
            result = me.su.sl2ia(resultSL);
        end
        function setIntVector(me,key,value)
            if isempty(value)
                return
            end
            valS = me.su.ia2sl(value);
            me.cfg.props.setPropertyList(key,valS);
        end
        function result = getTarget(me,key)
            result = Target;
            perts = me.dt.getDoubleVector(key,ones(6,1) * 1000);
            for i = 1:6
                if perts(i) < 999
                    result.setDispDof(i,perts(i));
                end
            end
        end
        function setTarget(me,key,value)
            perts = zeros(6,1);
            for i = 1:6
                if value.dispDofs(i)
                    perts(i) = value.disp(i);
                else
                    perts(i) = 1000;
                end
            end
            me.dt.setDoubleVector(key,perts);
        end
        function result = getTransVector(me,key,itemkey,itemSize)
            result = cell(itemSize,1);
            for i = 1: itemSize
                resultSL = me.cfg.props.getPropertyList(sprintf('%s.%s%d',key,itemkey,i));
                if isempty(resultSL) == 0
                    result{i} = me.su.sl2da(resultSL);
                end
            end
        end
        function setTransVector(me,key,itemkey,itemSize,value)
            if isempty(value)
                return
            end
            for i = 1: itemSize;
                if isempty(value{i})
                    continue
                end
                valS = me.su.da2sl(value{i});
                me.cfg.props.setPropertyList(sprintf('%s.%s%d',key,itemkey,i),valS);
            end
        end
        function result = getDofMatrix(me,key,itemkey,itemSize)
            result = cell(itemSize,1);
            for i = 1: itemSize
                rslt = eye(6);
                for d = 1:6
                    resultSL = me.cfg.props.getPropertyList(sprintf('%s.%s%d.%s',key,itemkey,i,me.dofL{d}));
                    if isempty(resultSL) == false
                        rslt(d,:) = me.su.sl2da(resultSL);
                    end
                end
                result{i} = rslt;
            end
        end
        function setDofMatrix(me,key,itemkey,itemSize,value)
            if isempty(value)
                return
            end
            for i = 1:itemSize
                if isempty(value{i})
                    continue
                end
                for d = 1:6
                    valS = me.su.da2sl(value{i}(d,:));
                    me.cfg.props.setPropertyList(sprintf('%s.%s%d.%s',key,itemkey,i,me.dofL{d}),valS);
                end
            end
        end

    end
end