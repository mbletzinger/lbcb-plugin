classdef OffsetsDataSet < handle
    properties
        sensorNames
        sensorValues
        lbcbNames
        lbcbValues
        offstcfg
        numLbcbs
    end
    methods
        function me = OffsetsDataSet(offstcfg,cfg,fact)
            me.offstcfg = offstcfg;
            ocfg = OmConfigDao(cfg);
            me.sensorNames = ocfg.sensorNames;
            me.lbcbNames = offstcfg.lbcbNames;
            me.sensorValues = zeros(length(me.sensorNames),1);
            me.lbcbValues = zeros(length(me.lbcbNames),1);
            me.numLbcbs = fact.cdp.numLbcbs();
        end
        function names = getNames(me)
            lbcbN = me.lbcbNames;
            if me.numLbcbs == 1
                lbcbN = me.lbcbNames(1:6);
            end
            names = cat(1,me.sensorNames, lbcbN);
        end
        function values = getValues(me)
            lbcbV = me.lbcbValues;
            if me.numLbcbs == 1
                lbcbV = me.lbcbValues(1:6);
            end
            values = cat(1,me.sensorValues, lbcbV);
        end
        function load(me)
            me.sensorValues = zeros(length(me.sensorNames),1);
            for n = 1:length(me.sensorNames)
                me.sensorValues(n) = me.offstcfg.setOffset(me.sensorNames{n});
            end
            me.lbcbValues = zeros(length(me.lbcbNames),1);
            for n = 1:length(me.lbcbNames)
                me.lbcbValues(n)= me.offstcfg.setOffset(me.lbcbNames{n});
            end
        end
        function import(me)
            me.offstcfg.import();
            me.load();
        end
        function export(me)
            me.offstcfg.export();
        end
        function save(me)
            me.offstcfg.save();
        end
        function saveCfg(me)
            for n = 1:length(me.sensorNames)
                me.offstcfg.setOffset(me.sensorNames{n},me.sensorValues(n));
            end
            for n = 1:length(me.lbcbNames)
                me.offstcfg.setOffset(me.lbcbNames{n},me.lbcbValues(n));
            end
        end
        function set(me,name, value)
            for n = 1:length(me.sensorNames)
                if strcmp(me.sensorNames{n}, name)
                    me.sensorValues(n) = value;
                    return;
                end
            end
            for n = 1:length(me.lbcbNames)
                if strcmp(me.lbcbNames{n}, name)
                    me.lbcbValues(n) = value;
                    return;
                end
            end
        end
        function update(me,initialPosition)
            for s = 1:length(me.sensorNames)
                me.sensorValues(s) = initialPosition.externalSensorsRaw(s);
            end
            for lbcb = 1 : me.numLbcbs
                for d = 1:6
                    me.lbcbValues(d + 6*(lbcb - 1)) = me.dat.initialPosition.lbcbCps{lbcb}.response.lbcb.disp(d);
                end
            end
        end
    end
end
