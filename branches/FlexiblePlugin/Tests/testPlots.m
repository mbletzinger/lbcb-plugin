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
ldispy = (edispy * .993) + .0026;
cdispy = edispy;
forcey = cs * 3;
edispz = sn* .01;
ldispz = (edispz * .993) + .0026;
cdispz = edispz;
forcez = cs * 85;
erotx = sn* .001;
lrotx = (erotx * .993) + .0026;
crotx = erotx;
momx = cs * 850;
eroty = sn* .0001;
lroty = (eroty * .993) + .0026;
croty = eroty;
momy = cs * 120;
erotz = sn* .0012;
lrotz = (erotz * .993) + .0026;
crotz = erotz;
momz = cs * 1200;



lgth = length(sn);
sub = 0;
cor = 0;
step = 0;

dat = hfact.dat;
ddisp = hfact.ddisp;

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
    
    cor = cor + 1;
    corD = sdf.createEmptyStepData(step, sub,cor);
    l1 = corD.lbcbCps{1};
    l2 = corD.lbcbCps{2};
    l1.response.lbcb.disp = lbcbR';
    l1.response.lbcb.force = forceR';
    l1.response.ed.disp = edR';
    l1.response.ed.force = forceR';
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
    if cor > 4
        cor = 0;
        sub = sub + 1;
        subD = sdf.createEmptyStepData(step, sub,0);
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
        dat.correctionTarget = subD;
        if mod(sub,8) == 0
            step = step + 1;
            if (step +1) * 40 > lgth
                break;
            end
            stepD = sdf.createEmptyStepData(step, 0, 0);
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
            dat.prevTarget = dat.curTarget;
            dat.curTarget = stepD;
        end
    end
    if s == 1
        ddisp.startMyVsDx(1);
        ddisp.startMyVsDx(0);
        ddisp.startRyVsDx(1);
        ddisp.startFxVsDx(1);
        ddisp.startDataTable();
    end
    ddisp.update();
    pause(.5);
end
