function clearNonControlDofs(me)
for i=1:6
    if me.dispDofs(i) == 0
        me.disp(i) = 0;
    end
    if me.forceDofs(i) == 0
        me.forces(i) = 0;
    end
end
end
