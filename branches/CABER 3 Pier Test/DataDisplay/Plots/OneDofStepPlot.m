classdef OneDofStepPlot < handle
    properties
        plot = {};
        cmdData = [];
        corData = [];
        tgtData = [];
        subData = [];
        rspData = [];
        isLbcb1 = 1;
        haveData = 0;
        dof
        dat
        cdp
    end
    methods
        function me = OneDofStepPlot(name,isLbcb1,dat, dof)
            me.dof = dof;
            me.dat = dat;
            me.plot = TargetPlot(name,{'correct target','response','command'});
            me.isLbcb1 = isLbcb1;
            me.plot.figNum = 1 + (isLbcb1 == false);
        end
        function displayMe(me)
                me.plot.displayMe(me.plot.lbl{me.dof});
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,ignored) %#ok<INUSD>
            stepNum = me.dat.curStepData.stepNum;
            if stepNum.step == 0
                return; %initial position no commands
            end
            cpsidx = 2;
            if me.isLbcb1
                cpsidx = 1;
            end
            if me.isLbcb1 == false && me.cdp.numLbcbs() < 2
                return;
            end
            cmdS = me.dat.curStepData;
            corS = me.dat.correctionTarget;

            d = me.dof;
            isForce = false;
            
            if d > 6
                d = d - 6;
                isForce = true;
            end
            
            if isForce
                cmd = cmdS.lbcbCps{cpsidx}.command.force(d);
                rsp = cmdS.lbcbCps{cpsidx}.response.force(d);
                cor = corS.lbcbCps{cpsidx}.command.force(d);
            else
                cmd = cmdS.lbcbCps{cpsidx}.command.disp(d);
                rsp = cmdS.lbcbCps{cpsidx}.response.disp(d);
                cor = corS.lbcbCps{cpsidx}.command.disp(d);
            end
            
            if(me.haveData)
                me.cmdData = cat(1, me.cmdData,cmd);
                me.corData = cat(1, me.corData,cor);
                me.rspData = cat(1, me.rspData,rsp);
            else
                me.haveData = 1;
                me.cmdData = cmd;
                me.corData = cor;
                me.rspData = rsp;
            end
            me.plot.update(me.corData,1);
            me.plot.update(me.rspData,2);
            me.plot.update(me.cmdData,3);
        end
    end
end
