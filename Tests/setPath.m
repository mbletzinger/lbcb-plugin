cwd = pwd;
cd ..;
rwd = pwd;
cd(cwd);
dlist = recurSetPath(rwd);
op = path;
oldp = regexp(op,'([^;]+)','match');
newpath = dlist;
oldrwd = strfind(oldp,rwd);

for o = 1: length(oldp)
    if isempty(oldrwd) == false && isempty(oldrwd{o}) == false
        continue;
    end
    newpath = { newpath{:}, oldp{o} }; %#ok<*AGROW>
end
pathline = newpath{1};
for p = 2:length(newpath)
    pathline = sprintf('%s;%s',pathline,newpath{p});
end
path(pathline);
savepath;
