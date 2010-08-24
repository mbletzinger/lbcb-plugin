classdef DisplayFactory < handle
    properties
        mainDisp
        dispIdxs
        disps
        idx
        checkHndls
    end
    methods
        function me = DisplayFactory(handle)
            me.mainDisp = handle;
            me.idx = 1;
            me.dispIdxs = org.nees.uiuc.simcor.matlab.HashTable();
            me.disps = {};
            DataDisplay.setMe(me);
        end
        function addDisplay(me,name,ref,chkhndl)
            me.dispIdxs.put(name,me.idx);
            dsp = { me.disps{1:(me.idx - 1)}, ref};
            me.disps{me.idx} = dsp;
            me.checkHndls{me.idx} = chkhndl;
            me.idx = me.idx + 1;
        end
        function initialize(me)
            ref = DataTable('Step DOF Data','DataTable');
            me.addDisplay('DataTable',ref,me.mainDisp.DataTable);
            ref = DataTable('Step DOF Data','DataTable');
            me.addDisplay('TotalFxVsLbcb1Dx',ref,me.mainDisp.TotalFxVsLbcb1Dx);
            me.addDisplay('TotalFxVsLbcb2Dx',ref,me.mainDisp.TotalFxVsLbcb2Dx);
            me.addDisplay('TotalMyVsLbcb1Dx',ref,me.mainDisp.TotalMyVsLbcb1Dx);
            me.addDisplay('TotalMyVsLbcb2Dx',ref,me.mainDisp.TotalMyVsLbcb2Dx);
            me.addDisplay('MyVsLbcb1Dx',ref,me.mainDisp.MyVsLbcb1Dx);
            me.addDisplay('MyVsLbcb2Dx',ref,me.mainDisp.MyVsLbcb2Dx);
            me.addDisplay('RyVsLbcb1Dx',ref,me.mainDisp.RyVsLbcb1Dx);
            me.addDisplay('RyVsLbcb2Dx',ref,me.mainDisp.RyVsLbcb2Dx);
            me.addDisplay('FxVsLbcb1Dx',ref,me.mainDisp.FxVsLbcb1Dx);
            me.addDisplay('FxVsLbcb2Dx',ref,me.mainDisp.FxVsLbcb2Dx);
            me.addDisplay('DxStepL1',ref,me.mainDisp.DxStepL1);
            me.addDisplay('DxStepL2',ref,me.mainDisp.DxStepL2);
            me.addDisplay('RyStepL1',ref,me.mainDisp.RyStepL1);
            me.addDisplay('RyStepL2',ref,me.mainDisp.RyStepL2);
            me.addDisplay('DzStepL1',ref,me.mainDisp.DzStepL1);
            me.addDisplay('DzStepL2',ref,me.mainDisp.DzStepL2);
            me.addDisplay('FzStepL1',ref,me.mainDisp.FzStepL1);
            me.addDisplay('FzStepL2',ref,me.mainDisp.FzStepL2);
        end
        function yes = isDisplaying(me,name)
            ref = me.disps{me.dispIdxs.get(name)};
            yes = ref.plot.isDisplayed;
        end
        function closeDisplay(me,name)
            i = me.dispIdxs.get(name);
            ref = me.disps{i};
            ref.undisplayMe();
            hndl = me.checkHndls{i};
            set(hndl,'Checked','off');
        end
        function openDisplay(me,name)
            i = me.dispIdxs.get(name);
            ref = me.disps{i};
            ref.displayMe();
            ref.isDisplayed = true;
            hndl = me.checkHndls{i};
            set(hndl,'Checked','on');
        end
        function updateDisplay(me,name,target)
            ref = me.disps{me.dispIdxs.get(name)};
            ref.update(target);
        end
        function updateAll(me,target)
            keys = me.dispIdxs.keys();
            lt = length(keys);
            for v = 1:lt
                name = char(keys(v));
                me.updateDisplay(name,target);
            end
        end
    end
    methods (Static)
        function setMe(me)
            global mySelf;
            mySelf = me;
        end
        function dispDeleted(src,event,name) %#ok<INUSD,INUSL>
            global mySelf;
            i = mySelf.dispIdxs.get(name);
            ref = mySelf.disps{i};
            ref.plot.isDisplayed = false;
            hndl = mySelf.checkHndls{i};
            set(hndl,'Checked','off');            
        end
    end
end