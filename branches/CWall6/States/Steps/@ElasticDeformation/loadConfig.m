function loadConfig(me)
ocfg = OmConfigDao(me.cdp.cfg);
% get sensors for both LBCBs
bapplied = ocfg.apply2Lbcb;
bpinLocations = ocfg.pinLocations;
bfixedLocations = ocfg.fixedLocations;
% bulimit = ocfg.sensorUpper;
% bllimit = ocfg.sensorLower;
% berror = ocfg.sensorErrorTol;

aselect = StateEnum({'LBCB1','LBCB2','BOTH'});
lbcb = 'LBCB2';
if me.isLbcb1
    lbcb = 'LBCB1';
end

ns = ocfg.numExtSensors;
me.pinLocations = zeros(3,ns);
me.fixedLocations = zeros(3,ns);

% filter for one LBCB
fs = 1;
for s = 1:ns
    aselect.setState(bapplied{s});
    if aselect.isState(lbcb) == false && aselect.isState('BOTH') == false
        continue;
    end
    me.pinLocations(:,fs) = bpinLocations{s};
    me.fixedLocations(:,fs) = bfixedLocations{s};
    fs = fs + 1;
end
ne = fs - 1;
me.pinLocations = me.pinLocations(:,1:ne);
me.fixedLocations = me.fixedLocations(:,1:ne);

me.transPert = ocfg.transPert;
me.rotPert = ocfg.rotPert;
me.optSetting.maxfunevals = ocfg.optsetMaxFunEvals;
me.optSetting.maxiter = ocfg.optsetMaxIter;
me.optSetting.tolfun = ocfg.optsetTolFun;
me.optSetting.tolx = ocfg.optsetTolX;
me.optSetting.jacob = ocfg.optsetJacob > 0; % question, it would be 'on' or 'off'
[n s a] = me.cdp.getFilteredExtSensors(me.isLbcb1); %#ok<NASGU,ASGLU>
me.initialReadings = zeros(1,ns);
    for s = 1:ns
        me.initialReadings(s) = me.offstcfg.getOffset(n{s});
    end
end