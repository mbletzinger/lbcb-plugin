function parseSimCorControlPointMsg(me,cmd, idx)
[mdl contents] = cmd.getContents();
cmdT = ModelControlPoint;
cmdT.parse(contents,mdl);
me.modelCps{idx}.command= cmdT;
end
