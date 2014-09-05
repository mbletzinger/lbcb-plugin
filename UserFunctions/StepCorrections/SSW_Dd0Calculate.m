function SSW_Dd0Calculate(me,step)
me.log.debug(dbstack,'Running calculate displacements fcn');
%------------------------------------------------------------------------%
%   Get configuration variables and force readings to perform calculations
%------------------------------------------------------------------------%
westArm = me.getCfg('WestArm');
northArm = me.getCfg('NorthArm');

initialReadings = zeros(1,ns1);
for s = 1:ns1
    initialReadings(s) = me.offstcfg.getOffset(n{s});
end

curReadings = step.lbcbCps{1}.externalSensors;

disp = curReadings - initialReadings;
east = disp(1);
north = disp(2);
west= disp(3);
avgdisp = mean(disp);
me.putArch('EdDz', avgdisp);
thetay = (west - east)/ westArm;
thetax = ( mean(east,west)-north) / northArm;

me.putArch('EdRy', thetay);
me.putArch('EdRx', thetax);
me.putArch('MeasEast', east);
me.putArch('MeasNorth', north);
me.putArch('MeasWest', west);
str = sprintf('ED Dz = %f, ED Ry = %f, ED Rx = %f\n',avgdisp, thetay, thetax);
me.log.debug(dbstack,str);

end