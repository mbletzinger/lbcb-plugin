classdef CorrectionVariables < handle
    properties
        cdp
        cfgH
        datH
        archH
    end
    methods
        function me = CorrectionVariables(cdp)
            me.cdp = cdp;
        end
        function val = getCfg(me,lbl)
            if me.existsCfg(lbl) == false
                me.log.error(dbstack,sprintf('"%s" Cfg variable does not exist',lbl));
                val = [];
                return;
            end
            val = me.cfgH.get(lbl);
        end
        function putCfg(me,lbl,val)
            me.cfgH.put(lbl,val);
        end
        function val = getDat(me,lbl)
            if me.existsDat(lbl) == false
                me.log.error(dbstack,sprintf('"%s" Dat variable does not exist',lbl));
                val = [];
                return;
            end
            val = me.datH.get(lbl);
        end
        function putDat(me,lbl,val)
            me.datH.put(lbl,val);
        end
        function val = getArch(me,lbl)
            if me.existsArch(lbl) == false
                me.log.error(dbstack,sprintf('"%s" Arch variable does not exist',lbl));
                val = [];
                return;
            end
            val = me.archH.get(lbl);
        end
        function putArch(me,lbl,val)
            me.archH.put(lbl,val);
        end
        function loadCfg(me)
            ccfg = ConfigVarsDao(me.cdp.cfg);
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
                k = char(keys(v));
                str = sprintf('%s/%s=%f',str,k,me.datH.get(k));
            end
        end
        function str = arch2String(me)
            str = '';
            keys = me.archH.keys();
            for v = 1:length(keys)
                k = char(keys(v));
                str = sprintf('%s/%s=%f',str,k,me.archH.get(k));
            end
        end
        function str = cfg2String(me)
            str = '';
            keys = me.cfgH.keys();
            for v = 1:length(keys)
                k = char(keys(v));
                str = sprintf('%s/%s=%f',str,k,me.cfgH.get(k));
            end
        end
        function yes = existsDat(me,key)
            yes = me.datH.exists(key);
        end
        function yes = existsArch(me,key)
            yes = me.archH.exists(key);
        end
        function yes = existsCfg(me,key)
            yes = me.cfgH.exists(key);
        end
        function saveData(me,step)
            keys = me.archH.keys();
            lt = length(keys);
            labels = cell(lt,1);
            values = zeros(lt,1);
            for v = 1:lt
                labels{v} = char(keys(v));
            end
            labels = sort(labels);
            for v = 1:lt
                if me.existsArch(labels{v})
                    values(v) = me.getArch(labels{v});
                end
            end
            step.cData.labels = labels;
            step.cData.values = values;
            me.log.debug(dbstack,sprintf('Saved Arch as %s',step.cData.toString()));
        end
    end
end