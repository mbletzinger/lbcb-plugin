function result = StringList2CellArray(list)
length = list.size();
result = cell(length,1);
for i = 0:length
    result(i) = list.get(i);
end
end