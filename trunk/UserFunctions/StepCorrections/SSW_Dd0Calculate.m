function SSW_Dd0Calculate(me,step)
me.log.debug(dbstack,'Running calculate displacements fcn');
%------------------------------------------------------------------------%
%   Get configuration variables and force readings to perform calculations
%------------------------------------------------------------------------%
westArm = me.getCfg('WestArm');
northArm = me.getCfg('NorthArm');
[n, ~, ~] = me.cdp.getFilteredExtSensors(1); 
initialReadings = zeros(1,3);
for s = 1:3
    initialReadings(s) = me.offstcfg.getOffset(n{s});
end

curReadings = step.lbcbCps{1}.externalSensors;
prevL1 = step.lbcbCps{1}.command.disp(3);
prevL2 = step.lbcbCps{2}.command.disp(3);
me.putArch('L1PrevCmdDz', prevL1);
me.putArch('L2PrevCmdDz', prevL2);

disp = curReadings - initialReadings;
east = disp(1);
north = disp(2);
west= disp(3);
avgdisp = mean(disp);
me.putArch('EdDz', avgdisp);
thetay = (west - east)/ westArm;
thetax = ( (east+west)/2 -north) / northArm;
% thetax = ( (east+east)/2 -north) / northArm;

me.putArch('EdRy', thetay);
me.putArch('EdRx', thetax);
me.putArch('MeasEast', east);
me.putArch('MeasNorth', north);
me.putArch('MeasWest', west);
str = sprintf('ED Dz = %f, ED Ry = %f, ED Rx = %f\n',avgdisp, thetay, thetax);
me.log.debug(dbstack,str);

end