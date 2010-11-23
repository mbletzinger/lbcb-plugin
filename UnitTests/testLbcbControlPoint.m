function test_suite = testLbcbControlPoint
initTestSuite;

function test_clone

t = LbcbControlPoint();

t.response.lbcb.disp = [1 0 2 0 3 0]';
t.response.lbcb.force = [4 0 5 0 6 0]';
t.response.ed.disp = [7 0 8 0 9 0]';
t.response.ed.force = [10 0 11 0 12 0]';

index1 = (1:3)';
value1 = (1:3)';

setDispDof(t.command,index1,value1);

index2 = (4:6)';
value2 = (4:6)';

setForceDof(t.command,index2,value2);

clearNonControlDofs(t.command);

dispDofs1 = [1 1 1 0 0 0]';
forceDofs1 = [0 0 0 1 1 1]';
disp1 = [1 2 3 0 0 0]';
force1 = [0 0 0 4 5 6]';

w = clone(t);

assertEqual(t.response.ed.disp,w.response.ed.disp)
assertEqual(t.response.ed.force,w.response.ed.force)
assertEqual(t.response.lbcb.disp,w.response.lbcb.disp)
assertEqual(t.response.lbcb.force,w.response.lbcb.force)

assertEqual(t.command.dispDofs,w.command.dispDofs)
assertEqual(t.command.forceDofs,t.command.forceDofs)
assertEqual(t.command.disp,w.command.disp)
assertEqual(t.command.force,w.command.force)

w.response.ed.disp = [1 0 2 0 3 0]';
w.response.ed.force = [4 0 5 0 6 0]';
w.response.lbcb.disp = [7 0 8 0 9 0]';
w.response.lbcb.force = [10 0 11 0 12 0]';

index3 = (4:6)';
value3 = (4:6)';

setDispDof(w.command,index3,value3);

index4 = (1:3)';
value4 = (1:3)';

setForceDof(w.command,index4,value4);

clearNonControlDofs(t.command);

dispDofs2 = [1 1 1 0 0 0]';
forceDofs2 = [0 0 0 1 1 1]';
disp2 = [4 5 6 0 0 0]';
force2 = [0 0 0 1 2 3]';

assertFalse(isequalwithequalnans(t.response.ed.disp,w.response.ed.disp),sprintf('t.response.ed.disp = w.response.ed.disp'))
assertFalse(isequalwithequalnans(t.response.ed.force,w.response.ed.force),sprintf('t.response.ed.force = w.response.ed.force'))
assertFalse(isequalwithequalnans(t.response.ed.disp,w.response.ed.disp),sprintf('t.response.ed.disp = w.response.ed.disp'))
assertFalse(isequalwithequalnans(t.response.ed.force,w.response.ed.force),sprintf('t.response.ed.force = w.response.ed.force'))

assertFalse(isequalwithequalnans(t.command.dispDofs,w.command.dispDofs),sprintf('t.command.dispDofs = w.command.dispDofs'))
assertFalse(isequalwithequalnans(t.command.forceDofs,w.command.forceDofs),sprintf('t.command.forceDofs = t.command.forceDofs'))
assertFalse(isequalwithequalnans(t.command.disp,w.command.disp),sprintf('t.command.disp = w.command.disp'))
assertFalse(isequalwithequalnans(t.command.force,w.command.force),sprintf('t.command.force = w.command.force'))

function test_toString

t = LbcbControlPoint();

t.response.lbcb.disp = [1 0 2 0 3 0]';
t.response.lbcb.force = [4 0 5 0 6 0]';
t.response.ed.disp = [7 0 8 0 9 0]';
t.response.ed.force = [10 0 11 0 12 0]';

index1 = (1:3)';
value1 = (1:3)';

setDispDof(t.command,index1,value1);

index2 = (4:6)';
value2 = (4:6)';

setForceDof(t.command,index2,value2);

clearNonControlDofs(t.command);

t_str = toString(t);

str = sprintf('/command=/Dx=1.000000/Dy=2.000000/Dz=3.000000/Mx=4.000000/My=5.000000/Mz=6.000000');
str = sprintf('%s\n\t/response=/lbcb/Dx=1.000000/Dy=0.000000/Dz=2.000000/Rx=0.000000/Ry=3.000000/Rz=0.000000/Fx=4.000000/Fy=0.000000/Fz=5.000000/Mx=0.000000/My=6.000000/Mz=0.000000',str);
str = sprintf('%s\n\t/ed/Dx=7.000000/Dy=0.000000/Dz=8.000000/Rx=0.000000/Ry=9.000000/Rz=0.000000/Fx=10.000000/Fy=0.000000/Fz=11.000000/Mx=0.000000/My=12.000000/Mz=0.000000',str);
str = sprintf('%s\n\t/id=4',str);
str = sprintf('%s\n\t/externalSensors',str);
str = sprintf('%s\n\t/deltas/dx=0.000000/dy=0.000000/dz=0.000000/rx=0.000000/ry=0.000000/rz=0.000000',str);

assertEqual(str,t_str)