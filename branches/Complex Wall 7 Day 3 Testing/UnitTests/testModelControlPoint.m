function test_suite = testModelControlPoint
initTestSuite;

function test_clone

t = ModelControlPoint();

index1 = (1:3)';
value1 = (1:3)';

setDispDof(t.response,index1,value1);

index2 = (4:6)';
value2 = (4:6)';

setForceDof(t.response,index2,value2);

clearNonControlDofs(t.response);

dispDofs1 = [1 1 1 0 0 0]';
forceDofs1 = [0 0 0 1 1 1]';
disp1 = [1 2 3 0 0 0]';
force1 = [0 0 0 4 5 6]';

assertEqual(dispDofs1,t.response.dispDofs)
assertEqual(forceDofs1,t.response.forceDofs)
assertEqual(disp1,t.response.disp)
assertEqual(force1,t.response.force)

index3 = (1:3)';
value3 = (7:9)';

setDispDof(t.command,index3,value3);

index4 = (4:6)';
value4 = (10:12)';

setForceDof(t.command,index4,value4);

clearNonControlDofs(t.command);

dispDofs2 = [1 1 1 0 0 0]';
forceDofs2 = [0 0 0 1 1 1]';
disp2 = [7 8 9 0 0 0]';
force2 = [0 0 0 10 11 12]';

assertEqual(dispDofs2,t.command.dispDofs)
assertEqual(forceDofs2,t.command.forceDofs)
assertEqual(disp2,t.command.disp)
assertEqual(force2,t.command.force)

w = clone(t);

assertEqual(w,t)

w.command.disp = [13 14 15 0 0 0]';
w.command.force = [0 0 0 16 17 18]';
w.response.disp = [19 20 21 0 0 0]';
w.response.force = [0 0 0 22 23 24]';

assertFalse(isequalwithequalnans(t.command.disp ,w.command.disp),sprintf('t.command.disp = w.command.disp'))
assertFalse(isequalwithequalnans(t.command.force ,w.command.force),sprintf('t.command.force = w.command.force'))
assertFalse(isequalwithequalnans(t.response.disp ,w.response.disp),sprintf('t.response.disp = w.response.disp'))
assertFalse(isequalwithequalnans(t.response.force ,w.response.force),sprintf('t.response.force = w.response.force'))

%Explanation of assertFalse: 
% It checks the status of the condition included. If the condition results
% in a logical 1, i.e., true, then, it results in an error in the code, as
% the assertion that "the condition is false" is false! It therefore
% then prints out whatever message you want it to print.
% If the condition however results in a logical 0, i.e., false, then, the
% assertion that "the statement is false" is true; so there is no error in
% the code and it prints out no message.

function test_toString

t = ModelControlPoint();

index1 = (1:3)';
value1 = (1:3)';

setDispDof(t.response,index1,value1);

index2 = (4:6)';
value2 = (4:6)';

setForceDof(t.response,index2,value2);

clearNonControlDofs(t.response);

index3 = (1:3)';
value3 = (7:9)';

setDispDof(t.command,index3,value3);

index4 = (4:6)';
value4 = (10:12)';

setForceDof(t.command,index4,value4);

clearNonControlDofs(t.command);

t_str = toString(t);
str = sprintf('/addr=/command=/Dx=7.000000/Dy=8.000000/Dz=9.000000/Mx=10.000000/My=11.000000/Mz=12.000000');
str = sprintf('%s\n\t/response=/Dx=1.000000/Dy=2.000000/Dz=3.000000/Mx=4.000000/My=5.000000/Mz=6.000000',str);

assertEqual(str,t_str)