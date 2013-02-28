function test_suite = testLbcbReading
initTestSuite;

function test_clone

t = LbcbReading();

t.ed.disp = [1 0 2 0 3 0]';
t.ed.force = [0 4 0 5 0 6]';

t.lbcb.disp = [7 0 8 0 9 0]';
t.lbcb.force = [0 10 0 11 0 12]';

w = clone(t);

assertEqual(t.ed.disp,w.ed.disp)
assertEqual(t.ed.force,w.ed.force)
assertEqual(t.lbcb.disp,w.lbcb.disp)
assertEqual(t.lbcb.force,w.lbcb.force)

w.lbcb.disp = [1 0 2 0 3 0]';
w.lbcb.force = [0 4 0 5 0 6]';

w.ed.disp = [7 0 8 0 9 0]';
w.ed.force = [0 10 0 11 0 12]';

assertFalse(isequalwithequalnans(t.ed.disp,w.ed.disp),sprintf('t.ed.disp = w.ed.disp'))
assertFalse(isequalwithequalnans(t.ed.force,w.ed.force),sprintf('t.ed.force = w.ed.force'))
assertFalse(isequalwithequalnans(t.lbcb.disp,w.lbcb.disp),sprintf('t.lbcb.disp = w.lbcb.disp'))
assertFalse(isequalwithequalnans(t.lbcb.force,w.lbcb.force),sprintf('t.lbcb.force = w.lbcb.force'))

function test_toString

t = LbcbReading();

t.ed.disp = [1 0 2 0 3 0]';
t.ed.force = [0 4 0 5 0 6]';

t.lbcb.disp = [7 0 8 0 9 0]';
t.lbcb.force = [0 10 0 11 0 12]';

t_str = toString(t);
str = sprintf('/lbcb/Dx=7.000000/Dy=0.000000/Dz=8.000000/Rx=0.000000/Ry=9.000000/Rz=0.000000/Fx=0.000000/Fy=10.000000/Fz=0.000000/Mx=11.000000/My=0.000000/Mz=12.000000');
str = sprintf('%s\n\t/ed/Dx=1.000000/Dy=0.000000/Dz=2.000000/Rx=0.000000/Ry=3.000000/Rz=0.000000/Fx=0.000000/Fy=4.000000/Fz=0.000000/Mx=5.000000/My=0.000000/Mz=6.000000',str);
str = sprintf('%s\n\t/id=1',str);