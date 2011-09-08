function str = dof2s(me,a)
lbl = { 'Dx', 'Dy', 'Dz', 'Rx', 'Ry', 'Rz'};
istr = '';
for d = 1:6
    istr = sprintf('%s/%s=%f',istr,lbl{d},a(d));
end
    str= sprintf('\n\t%s',istr);
end