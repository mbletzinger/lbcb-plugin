function test_suite = testTarget
initTestSuite;

function test_Initialization_Target

t = Target();

dispDofs = zeros(6,1);
forceDofs = zeros(6,1);

assertEqual(dispDofs,t.dispDofs)
assertEqual(forceDofs,t.forceDofs)

function test_Set_And_ClearControlDofs_And_Clone

t = Target();

index1 = (1:3)';
value1 = (1:3)';

setDispDof(t,index1,value1);

index2 = (4:6)';
value2 = (4:6)';

setForceDof(t,index2,value2);

clearNonControlDofs(t);

w = clone(t);

dispDofs = [1 1 1 0 0 0]';
forceDofs = [0 0 0 1 1 1]';
disp = [1 2 3 0 0 0]';
force = [0 0 0 4 5 6]';

assertEqual(dispDofs,t.dispDofs)
assertEqual(forceDofs,t.forceDofs)
assertEqual(disp,t.disp)
assertEqual(force,t.force)

assertEqual(w,t)

% t.setDispDof(4,1);
% w.setDispDof(4,2);
% 
% assertFalse(isequalwithequalnans(w,t),sprintf('%s ~= %s',w.toString,t.toString))

%Explanation of assertFalse: If the condition is true, i.e., = 0, then it
%prints out the message. If false, does nothing!

function test_toString

t = Target();

index1 = (1:3)';
value1 = (1:3)';

setDispDof(t,index1,value1);

index2 = (4:6)';
value2 = (4:6)';

setForceDof(t,index2,value2);

clearNonControlDofs(t);

t_str = toString(t);
str = ('/Dx=1.000000/Dy=2.000000/Dz=3.000000/Mx=4.000000/My=5.000000/Mz=6.000000');

assertEqual(str,t_str)