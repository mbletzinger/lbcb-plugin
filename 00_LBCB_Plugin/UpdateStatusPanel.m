function UpdateStatusPanel(varargin)
% ET_GUI_Process_Text
% Update GUI text
tmpstr = get(varargin{1},'string');
max_num_row  = 6;	% maximum number of rows

if varargin{3}==1
	tmpstr = {tmpstr{:} varargin{2}};
	curLength = length(tmpstr);
	if curLength>max_num_row
		tmpstr = {tmpstr{curLength-max_num_row+1:curLength}};
	end
	set(varargin{1},'string',tmpstr);
elseif varargin{3}==2
	tmpstr{end}=varargin{2};
	set(varargin{1},'string',tmpstr);
elseif varargin{3}==3
	Tmp_Str=sprintf('%s   %s',tmpstr{end},varargin{2});
	tmpstr{end}=Tmp_Str;
	set(varargin{1},'string',tmpstr);
end

