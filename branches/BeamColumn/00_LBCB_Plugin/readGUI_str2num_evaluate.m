function [ConvertValue ConvertStatus] = readGUI_str2num_evaluate (str_val, ConvertStatus)

[ConvertValue, Status] = str2num(str_val);
if length(ConvertValue)~=1
	Status=0;
end
ConvertStatus=[ConvertStatus;Status];