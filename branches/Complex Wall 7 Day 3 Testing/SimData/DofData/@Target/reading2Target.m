% Imports the LBCB reading
function reading2Target(me,reading)
me.disp = reading.disp;
me.dispDofs = ones(6,1);
me.force = reading.force;
me.forceDofs = ones(6,1);
end
