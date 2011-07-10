function  archiveCorrections(type,cor)
dofL = { 'Dx', 'Dy', 'Dz', 'Rx', 'Ry', 'Rz'};
lbcb = 2;
if me.isLbcb1
    lbcb = 1;
end
for d = 1:6
    if me.cdp.isCorrectDof(l,d)
        label = sprintf('%sL%d%s',type,lbcb,dofL{d});
        me.archH.set(label,cor(d));
    end
end
end
