% Fills in the DOF data from a DofData structure
function setCurrentPosition(me,dofData)
me.disp = dofData.disp;
me.force = dofData.force;
end
