%function UpdateMonitorPanel_Coord (handles,Transform,FDCtrlDoF, FDCtrlDoFMode, Str_In, format_str, varargin);
function UpdateMonitorPanel_Coord (handles, varargin);
%-------------------------------------------------------------------------------------------------------
% varargin{1}:         Tag for static text    
% varargin{2}:         Variables
% varargin{3} == 1,    Control Mode in GUI
%                2,    Model Coordinate System in GUI
%
% by Sung Jig Kim, 01/01/2008
%-------------------------------------------------------------------------------------------------------
%TXT_StrPanel={handles.TXT_Disp_T_Model};
%hndl = {format_str,Transform,FDCtrlDoF,1};
%UpdateMonitorPanel_Coord (handles, TXT_StrPanel, hndl, 2);
Str_In=cell(6,1); Str_Out=cell(6,1);
format_str=varargin{2}{1};
Transform =varargin{2}{2};
FDCtrlDoF =varargin{2}{3};
% Get String
if length(varargin{1})==1
	Str_In=get(varargin{1}{1}, 'string');
else
	for i=1:6
		Str_In{i}=get(varargin{1}{i}, 'string');
	end
end

% Change '  -  ' to zero
pat=' - ';
for i=1:6
	Str_In{i}=regexprep(Str_In{i},pat,'0');
	Str_data(i,1)=str2num(Str_In{i});
end

switch varargin{3}
	case 1  % Control Mode in GUI  
		if Transform==1  % Model coordinate system panel
			if varargin{2}{4}==1
				if handles.MDL.CtrlMode ==3
					for i=1:6
						if FDCtrlDoF(i)==1
							Str_Out{i} = sprintf (format_str,Str_data(i,1));
						else
							Str_Out{i} = sprintf('     -     ');
						end
					end
				else
					if sum(FDCtrlDoF)>1
						for i=1:6
							Str_Out{i} = sprintf (format_str,Str_data(i,1));
						end
					else
						for i=1:6
							Str_Out{i} = sprintf('     -     ');
						end
					end
				end
			elseif varargin{2}{4}==2
				for i=1:6
					Str_Out{i} = sprintf (format_str,Str_data(i,1));
				end
			end	 
		else     % LBCB coordinate system panel
			if varargin{2}{4}==1
				for i=1:6
					if FDCtrlDoF(i)==1
						Str_Out{i} = sprintf (format_str,Str_data(i,1));
					else
						Str_Out{i} = sprintf('     -     ');
					end
				end
			elseif varargin{2}{4}==2
				for i=1:6
					Str_Out{i} = sprintf (format_str,Str_data(i,1));
				end
			end	
		
		end
		
	case 2 % Model Coordinate System in GUI
		Str_data=Transform*Str_data;
		if varargin{2}{4}==1
			FDCtrlDoF=abs(Transform*FDCtrlDoF);
			if handles.MDL.CtrlMode ==3
				for i=1:6
					if FDCtrlDoF(i)==1
						Str_Out{i} = sprintf (format_str,Str_data(i,1));
					else
						Str_Out{i} = sprintf('     -     ');
					end
				end
			else
				if sum(FDCtrlDoF)>1
					for i=1:6
						Str_Out{i} = sprintf (format_str,Str_data(i,1));
					end
				else
					for i=1:6
						Str_Out{i} = sprintf('     -     ');
					end
				end
			end
		elseif varargin{2}{4}==2
			for i=1:6
				Str_Out{i} = sprintf (format_str,Str_data(i,1));
			end
		end
end

% Update String
if length(varargin{1})==1
	set(varargin{1}{1},    'string',Str_Out);
else
	for i=1:6
		set(varargin{1}{i},    'string',Str_Out{i});
	end
end