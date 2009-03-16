function A = Cumulative(B)

A = zeros(1,4);
index = size(B);
index = index(1);
for i = 1:index
    A = [A; B(i,2), sum(B(1:i,3)), sum(B(1:i,4)), sum(B(1:i,7))];
end
A(1,:) = [];