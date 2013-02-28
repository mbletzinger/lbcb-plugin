function test_suite = testDofData
initTestSuite;


function testInitializationDofData

t = DofData();
t.disp = (1.0:6.0)';
t.force = 6+(1.0:6.0)';

disp = (1.0:6.0)';
force = 6+(1.0:6.0)';

assertEqual(disp,t.disp)
assertEqual(force,t.force)

function testtoString

t = DofData();
t.disp = (1.0:6.0)';
t.force = 6+(1.0:6.0)';
t_str = toString(t);
str = ('/Dx=1.000000/Dy=2.000000/Dz=3.000000/Rx=4.000000/Ry=5.000000/Rz=6.000000/Fx=7.000000/Fy=8.000000/Fz=9.000000/Mx=10.000000/My=11.000000/Mz=12.000000');

assertEqual(str,t_str)