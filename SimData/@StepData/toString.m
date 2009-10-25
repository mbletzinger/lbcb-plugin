function str = toString(me)
str = sprintf('Step=%s\n',me.stepNum.toString());
if isempty(me.lbcbCps)
    str = sprintf('%s/LBCB readings=',str,'none');
else
    for l = 1:StepData.numLbcbs()
        str = sprintf('%s/LBCB%d=%s\n',str,l,me.lbcbCps{l}.toString());
    end
end
[n s a] = me.getExtSensors(); %#ok<NASGU>
str = sprintf('%s\nexternalSensorsRaw=',str);
for s = 1:length(me.externalSensorsRaw)
    str = sprintf('%s/%s=%f',str,n{s},me.externalSensorsRaw(s));
end
str = sprintf('%s\nderivedData=%s',str,me.dData.toString());
end