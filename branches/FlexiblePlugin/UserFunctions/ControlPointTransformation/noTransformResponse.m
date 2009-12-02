function noTransformResponse(me)
idx = 1;
for resp = 1 : me.lbcbCps
    me.modelCps{idx}.response.disp = resp.response.disp;
    me.modelCps{idx}.response.force = resp.response.force;
    me.modelCps{idx}.response.dispDofs = resp.command.dispDofs;
    me.modelCps{idx}.response.forceDofs = resp.command.forceDofs;
    me.modelCps{idx}.response.clearNonControlDofs();
    idx = idx + 1;
end
end