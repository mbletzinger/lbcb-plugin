function str = toString(me)
labels = {'dx' 'dy' 'dz' 'rx' 'ry' 'rz'};
str = '';
for v = 1:length(me.disp)
    if me.dispDofs(v)
        str = sprintf('%s/%s=%f',str,labels{v},me.disp(v));
    end
end
labels = {'fx' 'fy' 'fz' 'mx' 'my' 'mz'};
for v = 1:length(me.force)
    if me.forceDofs(v)
        str = sprintf('%s/%s=%f',str,labels{v},me.force(v));
    end
end
end
