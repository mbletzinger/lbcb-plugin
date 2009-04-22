function send_str = Format_Rtn_Data(MDL)

send_str = sprintf('OK\t0\tdummy\tMDL-%02d-%02d\t',0,1);

if MDL.IN_DOF(1), send_str = [send_str sprintf('x\tdisplacement\t%.10e\t',MDL.M_Disp(1))];, end;
if MDL.IN_DOF(2), send_str = [send_str sprintf('y\tdisplacement\t%.10e\t',MDL.M_Disp(2))];, end;
if MDL.IN_DOF(3), send_str = [send_str sprintf('z\tdisplacement\t%.10e\t',MDL.M_Disp(3))];, end;
if MDL.IN_DOF(4), send_str = [send_str sprintf('x\trotation\t%.10e\t',    MDL.M_Disp(4))];, end;
if MDL.IN_DOF(5), send_str = [send_str sprintf('y\trotation\t%.10e\t',    MDL.M_Disp(5))];, end;
if MDL.IN_DOF(6), send_str = [send_str sprintf('z\trotation\t%.10e\t',    MDL.M_Disp(6))];, end;

if MDL.IN_DOF(1), send_str = [send_str sprintf('x\tforce\t%.10e\t',       MDL.M_Forc(1))];, end;
if MDL.IN_DOF(2), send_str = [send_str sprintf('y\tforce\t%.10e\t',       MDL.M_Forc(2))];, end; 
if MDL.IN_DOF(3), send_str = [send_str sprintf('z\tforce\t%.10e\t',       MDL.M_Forc(3))];, end; 
if MDL.IN_DOF(4), send_str = [send_str sprintf('x\tmoment\t%.10e\t',      MDL.M_Forc(4))];, end;
if MDL.IN_DOF(5), send_str = [send_str sprintf('y\tmoment\t%.10e\t',      MDL.M_Forc(5))];, end;
if MDL.IN_DOF(6), send_str = [send_str sprintf('z\tmoment\t%.10e\t',      MDL.M_Forc(6))];, end;