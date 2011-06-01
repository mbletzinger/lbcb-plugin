% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%  steps - InputFile instance
%  curStep - The current LbcbStep
%  nextStep - The next LbcbStep as calculated by this class
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef NextStep < Step
    properties
        steps = [];
        stepsCompleted = 0;
        log = Logger('NextStep');
    end
    methods
        function me = NextStep()
            me = me@Step();
        end
        function start(me)
            me.stepsCompleted = false;
        end
        function done = isDone(me)
            done = 1;
            me.statusReady();
            if me.steps.started == false
                me.dat.substepTgtShift(me.steps.next());
                me.prelimAdjust();
                me.gui.updateCorrections();
                return;
            end
            if me.corrections.needsCorrection(me.dat.curStepData)
                me.dat.nextCorrectionStep(me.corrections.stepType());
                me.corrections.adjustTarget(me.dat.nextStepData);
                me.log.info(dbstack,'Generating correction step');
                me.gui.updateCorrections();
            else
                % get next input step
                stp = me.steps.next();
                me.stepsCompleted = me.steps.endOfFile;
                me.gui.updateCorrections();
                if me.stepsCompleted
                    return;
                else
                    me.dat.substepTgtShift(stp);
                    me.prelimAdjust();
                end
            end
            me.log.debug(dbstack,sprintf('Correction Target L1 is %s',me.dat.correctionTarget.lbcbCps{1}.command.toString()));
            if me.cdp.numLbcbs() > 1
                me.log.debug(dbstack,sprintf('Correction Target L2 is %s',me.dat.correctionTarget.lbcbCps{2}.command.toString()));
            end
            me.log.debug(dbstack,sprintf('Next Step L1 is %s',me.dat.nextStepData.lbcbCps{1}.command.toString()));
            if me.cdp.numLbcbs() > 1
                me.log.debug(dbstack,sprintf('Next Step L2 is %s',me.dat.nextStepData.lbcbCps{2}.command.toString()));
            end
        end
        
    end
end