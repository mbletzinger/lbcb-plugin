i = -pi:.1:pi;
ti = [ i i i i i i i i i i i i i i i i i i i i ];
sn = sin(ti);
cs = cos(ti);
tn = tan(ti);

cfg = Configuration;

s = SetupTest();
s.cfg = cfg;
s.genOmConfig();
s.genNetworkConfig();
s.genLogConfig()
s.genStepConfigSettings(true, true)
hfact = HandleFactory([],cfg);
s.hfact = hfact;
sdf = hfact.sdf;
%StepConfig('cfg',s.cfg);

edispx = sn;
ldispx = (sn * .995) + .0034;
cdispx = sn;
forcex = cs * 50;
edispy = sn* .05;
ldispy = (edispy * .993) + .46;
cdispy = edispy;
forcey = cs * 3;
edispz = sn* .01;
ldispz = (edispz * .993) + .46;
cdispz = edispz;
forcez = cs * 85;
erotx = sn* .001;
lrotx = (erotx * .993) + .46;
crotx = erotx;
momx = cs * 850;
eroty = sn* .0001;
lroty = (eroty * .993) + .46;
croty = eroty;
momy = cs * 120;
erotz = sn* .0012;
lrotz = (erotz * .993) + .46;
crotz = erotz;
momz = cs * 1200;



lgth = length(sn);
sub = 0;
cor = 5;
step = 0;

dat = hfact.dat;
ddisp = hfact.ddisp;

mainDisp.TotalFxVsLbcb1Dx = 0;
mainDisp.TotalFxVsLbcb2Dx = 0;
mainDisp.TotalMyVsLbcb1Dx = 0;
mainDisp.TotalMyVsLbcb2Dx = 0;
mainDisp.MyVsLbcb1Dx = 0;
mainDisp.MyVsLbcb2Dx = 0;
mainDisp.RyVsLbcb1Dx = 0;
mainDisp.RyVsLbcb2Dx = 0;
mainDisp.FxVsLbcb1Dx = 0;
mainDisp.FxVsLbcb2Dx = 0;
mainDisp.DxStepL1 = 0;
mainDisp.DxStepL2 = 0;
mainDisp.RyStepL1 = 0;
mainDisp.RyStepL2 = 0;
mainDisp.DzStepL1 = 0;
mainDisp.DzStepL2 = 0;
mainDisp.FzStepL1 = 0;
mainDisp.FzStepL2 = 0;
mainDisp.ResponseTable = 0;
mainDisp.CommandTable = 0;
mainDisp.SubstepsTable = 0;
mainDisp.DerivedTable = 0;
mainDisp.ReadingsTable = 0;
mainDisp.simStatesPanel = 0;
mainDisp.ipButton = 0;
mainDisp.wftButton = 0;
mainDisp.ptButton = 0;
mainDisp.esButton = 0;
mainDisp.strButton = 0;
mainDisp.simdButton = 0;
mainDisp.stepStatesPanel = 0;
mainDisp.nsButton = 0;
mainDisp.peButton = 0;
mainDisp.gcpButton = 0;
mainDisp.gcpButton = 0;
mainDisp.prButton = 0;
mainDisp.btButton = 0;
mainDisp.stpdButton = 0;
mainDisp.sourcePanel = 0;
mainDisp.ifButton = 0;
mainDisp.scorButton = 0;
mainDisp.srcnButton = 0;
mainDisp.correctionPanel = 0;
mainDisp.edButton = 0;
mainDisp.ddButton = 0;
mainDisp.cornButton = 0;

hfact.setGuiHandle(mainDisp);
cdLabels = {'Gooo','Test ABV','Fx total','My total' };

for s = 1:lgth
    corC = [cdispx(s) cdispy(s) cdispz(s) crotx(s) croty(s) crotz(s) ];
    subC = [cdispx((sub + 1) * 5) cdispy((sub + 1) * 5) cdispz((sub + 1) * 5) crotx((sub + 1) * 5) croty((sub + 1) * 5) crotz((sub + 1) * 5) ];
    stepC = [cdispx((step + 1) * 40) cdispy((step + 1) * 35) cdispz((step + 1) * 35) crotx((step + 1) * 35) croty((step + 1) * 35) crotz((step + 1) * 35) ];
    forceC = [forcex(s) forcey(s) forcez(s) momx(s) momy(s) momz(s) ];
    forceR = [forcex(s) forcey(s) forcez(s) momx(s) momy(s) momz(s) ];
    lbcbR = [ldispx(s) ldispy(s) ldispz(s) lrotx(s) lroty(s) lrotz(s) ];
    edR = [edispx(s) edispy(s) edispz(s) erotx(s) eroty(s) erotz(s) ];
    disp( [step + 1, mod(sub,8) + 1, cor, s])
    disp( [ stepC(:) subC(:) corC(:) ])
    cdValues = [cdispx(s) cdispy(s) cdispz(s) crotx(s) ];
    
    cor = cor + 1;
    if cor > 4
        cor = 0;
        corD = sdf.createEmptyStepData(step, sub,0);
        corD.cData.labels = cdLabels;
        corD.cData.values = cdValues;
        l1 = corD.lbcbCps{1};
        l2 = corD.lbcbCps{2};
        l1.response.lbcb.disp = .4 * lbcbR';
        l1.response.lbcb.force = .2 * forceR';
        l1.response.ed.disp = .4 * edR;
        l1.response.ed.force = .2 * forceR';
        l1.command.disp = .4 * subC;
        l1.command.force = .2 * forceC';
        l1.command.dispDofs = ones(6,1);
        l1.command.forceDofs = ones(6,1);
        
        l2.response.lbcb.disp = .4 * lbcbR';
        l2.response.lbcb.force = .2 * forceR';
        l2.response.ed.disp = .4 * edR';
        l2.response.ed.force = .2 * forceR';
        l2.command.disp = .4 * subC';
        l2.command.force = .2 * forceC';
        l2.command.dispDofs = ones(6,1);
        l2.command.forceDofs = ones(6,1);
        dat.correctionTarget = corD;
        
        subD = sdf.createEmptyStepData(step, sub,0);
        subD.cData.labels = cdLabels;
        subD.cData.values = cdValues;
        l1 = subD.lbcbCps{1};
        l2 = subD.lbcbCps{2};
        l1.response.lbcb.disp = lbcbR';
        l1.response.lbcb.force = forceR';
        l1.response.ed.disp = edR;
        l1.response.ed.force = forceR';
        l1.command.disp = subC;
        l1.command.force = forceC';
        l1.command.dispDofs = ones(6,1);
        l1.command.forceDofs = ones(6,1);
        
        l2.response.lbcb.disp = lbcbR';
        l2.response.lbcb.force = forceR';
        l2.response.ed.disp = edR';
        l2.response.ed.force = forceR';
        l2.command.disp = subC';
        l2.command.force = forceC';
        l2.command.dispDofs = ones(6,1);
        l2.command.forceDofs = ones(6,1);
        dat.curSubstepTgt = subD;

        if mod(sub,8) == 0
            step = step + 1;
            if (step +1) * 40 > lgth
                break;
            end
            stepD = sdf.createEmptyStepData(step, 0, 0);
            stepD.cData.labels = cdLabels;
            stepD.cData.values = cdValues;
            l1 = stepD.lbcbCps{1};
            l2 = stepD.lbcbCps{2};
            l1.response.lbcb.disp = lbcbR';
            l1.response.lbcb.force = forceR';
            l1.response.ed.disp = edR';
            l1.response.ed.force = forceR';
            l1.command.disp = subC';
            l1.command.force = forceC';
            l1.command.dispDofs = ones(6,1);
            l1.command.forceDofs = ones(6,1);
            
            l2.response.lbcb.disp = lbcbR';
            l2.response.lbcb.force = forceR';
            l2.response.ed.disp = edR';
            l2.response.ed.force = forceR';
            l2.command.disp = subC';
            l2.command.force = forceC';
            l2.command.dispDofs = ones(6,1);
            l2.command.forceDofs = ones(6,1);
            dat.prevStepTgt = dat.curStepTgt;
            dat.curStepTgt = stepD;
        end
        sub = sub + 1;
    end
    
    corD = sdf.createEmptyStepData(step, sub,cor);
%    corD.cData.labels = cdLabels;
%    corD.cData.values = cdValues;
    l1 = corD.lbcbCps{1};
    l2 = corD.lbcbCps{2};
    l1.response.lbcb.disp = .8 * lbcbR';
    l1.response.lbcb.force = .8 * forceR';
    l1.response.ed.disp = .9 * edR';
    l1.response.ed.force = .9 * forceR';
    l1.command.disp = corC';
    l1.command.force = forceC';
    l1.command.dispDofs = ones(6,1);
    l1.command.forceDofs = ones(6,1);
    
    l2.response.lbcb.disp = lbcbR';
    l2.response.lbcb.force = forceR';
    l2.response.ed.disp = edR';
    l2.response.ed.force = forceR';
    l2.command.disp = corC';
    l2.command.force = forceC';
    l2.command.dispDofs = ones(6,1);
    l2.command.forceDofs = ones(6,1);
    dat.prevStepData = dat.curStepData;
    dat.curStepData = corD;
    dat.nextStepData = corD;
    
    ddisp.updateAll(dat.curStepData);
    
    if s == 1
         ddisp.openDisplay('TotalFxVsLbcb1Dx');
%         ddisp.openDisplay('TotalFxVsLbcb2Dx');
%         ddisp.openDisplay('TotalMyVsLbcb1Dx');
         ddisp.openDisplay('TotalMyVsLbcb2Dx');
%         ddisp.openDisplay('MyVsLbcb1Dx');
%         ddisp.openDisplay('MyVsLbcb2Dx');
%         ddisp.openDisplay('RyVsLbcb1Dx');
%         ddisp.openDisplay('RyVsLbcb2Dx');
%         ddisp.openDisplay('FxVsLbcb1Dx');
%         ddisp.openDisplay('FxVsLbcb2Dx');
%          ddisp.openDisplay('DxStepL1');
%         ddisp.openDisplay('DxStepL2');
%         ddisp.openDisplay('RyStepL1');
%         ddisp.openDisplay('RyStepL2');
%         ddisp.openDisplay('DzStepL1');
%         ddisp.openDisplay('DzStepL2');
%         ddisp.openDisplay('FzStepL1');
%         ddisp.openDisplay('FzStepL2');
         ddisp.openDisplay('L1ResponseTable');
%         ddisp.openDisplay('L2ResponseTable');
%         ddisp.openDisplay('L1CommandTable');
%         ddisp.openDisplay('L2CommandTable');
%         ddisp.openDisplay('L1SubstepsTable');
%         ddisp.openDisplay('L2SubstepsTable');
%         ddisp.openDisplay('L1ReadingsTable');
%         ddisp.openDisplay('L2ReadingsTable');
         ddisp.openDisplay('DerivedTable');
    end
    pause(.5);
end
