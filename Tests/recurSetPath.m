function dirlist = recurSetPath(d)
lst = dir(d);
nms = { lst(:).name };
isDir = [ lst(:).isdir ];
hasDot = strfind(nms,'.');
hasAt = strfind(nms,'@');
hasXunit = strfind(nms,'xunit');
dlist = {};
for i = 1:length(lst)
    if isDir(i) == false
        continue;
    end
    %filter out directories that start with '.'
    hd = hasDot{i};
    if isempty(hd) == false && hd(1) == 1
        continue;
    end
    %filter out directories that start with '@'
    ha = hasAt{i};
    if isempty(ha) == false && ha(1) == 1
        continue;
    end
    %filter out xunit directories
    hx = hasXunit{i};
    if isempty(hx) == false
        continue;
    end
    nm = fullfile(d,nms{i});
    dlist = { dlist{:} nm }; %#ok<*CCAT>
end
sdlist = {};
for sd = 1:length(dlist)
    sdl = recurSetPath(dlist{sd});
    sdlist = { sdlist{:}, sdl{:} };
end
dirlist = { dlist{:}, sdlist{:} };
end