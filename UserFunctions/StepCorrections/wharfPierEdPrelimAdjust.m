function wharfPierEdPrelimAdjust(me,curStep, nextStep)

targetR = nextStep.lbcbCps{1}.command.disp;

prevOMcommandR = curStep.lbcbCps{1}.command.disp;

positionR = curStep.lbcbCps{1}.response.ed.disp;

newOMcommandR = prevOMcommandR + (targetR - positionR);

nextStep.lbcbCps{1}.command.disp([1 5]) = newOMcommandR([1 5]);

% if me.getCfg('PrelimEDFzFlag') == 1
%     nextStep.lbcbCps{1}.command.setForceDof(3,me.getDat('Fz1Target'));
%     nextStep.lbcbCps{2}.command.setForceDof(3,me.getDat('Fz2Target'));
%     nextStep.lbcbCps{1}.command.setForceDof(5,me.getDat('My1Target'));
%     nextStep.lbcbCps{2}.command.setForceDof(5,me.getDat('My2Target'));    
% elseif me.getCfg('PrelimEDFzFlag') == 2
%     nextStep.lbcbCps{1}.command.setForceDof(3,curStep.lbcbCps{1}.response.force(3));
%     nextStep.lbcbCps{2}.command.setForceDof(3,curStep.lbcbCps{2}.response.force(3));
%     nextStep.lbcbCps{1}.command.setForceDof(5,curStep.lbcbCps{1}.response.force(5));
%     nextStep.lbcbCps{2}.command.setForceDof(5,curStep.lbcbCps{2}.response.force(5));
% end

end