function msg = queryOM(me,controlPointSuffix)
send_str = sprintf('get-control-point\tdummy\tMDL-%02d-%02d:%s',0,1,controlPointSuffix);
Sendvar_LabView(obj,send_str);                           		% Send query command for control point j
[msg] = Getvar_LabView(obj,obj.CMD.RPLY_PUT_DATA);  		% Receive data for control point j
