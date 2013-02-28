function na = concatL(a,b)
sa = size(a,1);
bc = b;
if iscell(a)
    na = cell(sa + size(b,1),1);
    if iscell(b) == false
        bc = {b};
    end
else
    na = zeros(sa + size(b,1),1);
end
na(1:sa) = a(:);
na(sa+1:end) = bc(:);
end