function test_suite = testDerivedData
initTestSuite;

function test_clone
lbls = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz' 'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz'};

t = DerivedData();

% set.labels(t,lbls);
t.labels = lbls;
t.values = zeros(size(t.labels));

w = clone(t);

assertEqual(t.labels,w.labels)
assertEqual(t.values,w.values)

w.labels = {'Dx' 'Dy' 'Dz' 'Fx' 'Fy' 'Fz'};
w.values = zeros(1,6);

assertFalse(isequalwithequalnans(t.labels,w.labels),sprintf('t.labels = w.labels'))
assertFalse(isequalwithequalnans(t.values,w.values),sprintf('t.values = w.values'))

function test_toString

lbls = {'Dx' 'Dy' 'Dz' 'Rx' 'Ry' 'Rz' 'Fx' 'Fy' 'Fz' 'Mx' 'My' 'Mz'};

t = DerivedData();

t.labels = lbls;
t.values = zeros(size(t.labels));

str = toString(t);
t_str = '/Dx=0.000000/Dy=0.000000/Dz=0.000000/Rx=0.000000/Ry=0.000000/Rz=0.000000/Fx=0.000000/Fy=0.000000/Fz=0.000000/Mx=0.000000/My=0.000000/Mz=0.000000';

assertEqual(t_str,str)
