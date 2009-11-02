% Converts target to message format ie.
% x\tdisplacement\t1.00000e0-1
function msg = createMsg(me,values)
msg = '';
first = 1;
for i = 1:3
    if(me.dispDofs(i))
        if first
            msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',values.disp(i)));
            first = 0;
        else
            msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i},'displacement',values.disp(i)));
        end
    end
end
for i = 4:6
    if(me.dispDofs(i))
        if first
            msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',values.disp(i)));
            first = 0;
        else
            msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i-3},'rotation',values.disp(i)));
        end
    end
end
for i = 1:3
    if(me.forceDofs(i))
        if first
            msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i},'force',values.force(i)));
            first = 0;
        else
            msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i},'force',values.force(i)));
        end
    end
end
for i = 4:6
    if(me.forceDofs(i))
        if first
            msg = strcat(msg,sprintf('%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',values.force(i)));
            first = 0;
        else
            msg = strcat(msg,sprintf('\t%s\t%s\t%.10e\t',me.dofLabels{i-3},'moment',values.force(i)));
        end
    end
end
end
