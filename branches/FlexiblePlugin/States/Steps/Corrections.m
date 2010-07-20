classdef Corrections < handle
    properties
        cdp
        cfgH
        datH
        archH
    end
    methods
        function me = Corrections(cdp)
            me.cdp = cdp;
            me.cfgH = org.nees.uiuc.simcor.matlab.HashTable();
            me.datH = org.nees.uiuc.simcor.matlab.HashTable();
            me.archH = org.nees.uiuc.simcor.matlab.HashTable();
        end
        function val = getCfg(me,lbl)
            val = me.cfgH.get(lbl);
        end
        function putCfg(me,lbl,val)
            me.cfgH.put(lbl,val);
        end
        function val = getDat(me,lbl)
            val = me.datH.get(lbl);
        end
        function putDat(me,lbl,val)
            me.datH.put(lbl,val);
        end
        function val = getArch(me,lbl)
            val = me.archH.get(lbl);
        end
        function putArch(me,lbl,val)
            me.archH.put(lbl,val);
        end
        function loadCfg(me)
            ccfg = CorrectionsSettingsDao(me.cdp.cfg);
            cfgL = ccfg.cfgLabels;
            cfgV = ccfg.cfgValues;
            lgt = size(cfgL,1);
            for v = 1:lgt
                me.cfgH.put(cfgL{v},cfgV(v));
            end
        end
        function str = dat2String(me)
            str = '';
            keys = me.datH.keys();
            for v = 1:length(keys)
                k = char(keys{v});
                str = sprintf('%s/%s=%f',str,k,me.datH.get(k));
            end
        end
        function str = arch2String(me)
            str = '';
            keys = me.archH.keys();
            for v = 1:length(keys)
                k = char(keys{v});
                str = sprintf('%s/%s=%f',str,k,me.archH.get(k));
            end
        end
        function str = cfg2String(me)
            str = '';
            keys = me.cfgH.keys();
            for v = 1:length(keys)
                k = char(keys{v});
                str = sprintf('%s/%s=%f',str,k,me.cfgH.get(k));
            end
        end
        function saveData(me,step)
            keys = me.archH.keys();
            lt = length(keys);
            labels = cell(lt,1);
            values = zeros(lt,1);
            for v = 1:lt
                labels{v} = char(keys(v));
                values(v) = me.archH.get(labels{v});
            end
            step.cData.labels = labels;
            step.cData.values = values;
        end
    end
end