function num = numDofs(me)
num = 0;
for d = 1:6
    num = num + me.dispDofs(d);
    num = num + me.forceDofs(d);
end
end
