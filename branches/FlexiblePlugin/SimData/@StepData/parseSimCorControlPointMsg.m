function parseSimCorControlPointMsg(me,cmd, idx)
[mdl contents] = cmd.getContents();
cmdT = modelCps;
cmdT.parse(contents,mdl);
me.modelCps{idx}.command= cmdT;
end
