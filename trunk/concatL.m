function na = concatL(a,b)
sa = size(a,1);
if iscell(a)
    na = cell(sa + size(b,1),1);
else
    na = zeros(sa + size(b,1),1);
end
na(1:sa) = a(:);
na(sa+1:end) = b(:);
end