% Sets a displacement DOF
function setDispDof(me,index,value)
me.disp(index) = value;
me.dispDofs(index) = 1;
end
