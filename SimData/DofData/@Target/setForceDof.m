% Sets a force DOF
function setForceDof(me,index,value)
me.force(index) = value;
me.forceDofs(index) = 1;
end
