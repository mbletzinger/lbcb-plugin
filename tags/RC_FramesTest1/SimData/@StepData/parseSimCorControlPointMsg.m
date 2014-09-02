function good = parseSimCorControlPointMsg(me,cmd, idx)
[mdl contents] = cmd.getContents();
good = 1;
if isempty(contents)
    good = 0;
    return;
end

cmdT = ModelControlPoint;
cmdT.parse(contents,mdl);
me.modelCps{idx}.command= cmdT;
end
