function str = toString(me)
str = '';
for v = 1:length(me.disp)
    if me.dispDofs(v)
        str = sprintf('%s/%s=%f',str,me.labels{v},me.disp(v));
    end
end
for v = 1:length(me.force)
    if me.forceDofs(v)
        str = sprintf('%s/%s=%f',str,me.labels{v + 6},me.force(v));
    end
end
end
