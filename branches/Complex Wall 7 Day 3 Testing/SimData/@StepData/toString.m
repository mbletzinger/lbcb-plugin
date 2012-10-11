function str = toString(me)
str = sprintf('Step=%s\n',me.stepNum.toString());
if isempty(me.lbcbCps)
    str = sprintf('%s/LBCB readings=',str,'none');
else
    for l = 1:me.cdp.numLbcbs()
        str = sprintf('%s/LBCB%d=%s\n',str,l,me.lbcbCps{l}.toString());
    end
end
str = sprintf('%s\nexternalSensorsRaw=',str);
if isempty(me.externalSensorsRaw) == 0
    [n s a] = me.cdp.getExtSensors(); %#ok<NASGU>
    for s = 1:length(n)
        str = sprintf('%s/%s=%f',str,n{s},me.externalSensorsRaw(s));
    end
end
str = sprintf('%s\narchivedData=%s',str,me.cData.toString());
if me.isLastSubstep
    str = sprintf('%s[IsLastSubstep]',str);
end
end