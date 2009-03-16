function [deltas] = DeltaString(A)

deltas = zeros(1,5);
max = size(A);
max = max(1);
for i = 1:max -1
    deltas = [deltas; A(i,1), A(i+1,1), A(i+1,2:4) - A(i,2:4)];
end
deltas(1,:) = [];