% script for Plugin_Initialize.m
function Plugin_Initialize_CreateFile (TestDate_Str);

%DateStr=clock;
%TestDate_Str=sprintf('%04d%02d%02d%02d%02d',DateStr(1:5));


FileName='NetwkLog_LBCB.txt';
if exist(FileName)~=0
	FileName2=sprintf('Backup_NetwkLog_LBCB_%4d%02d%02d%02d%02d%2.0f.txt',clock);   
	copyfile(FileName,FileName2); 
	delete (FileName);
end
FileName='NetwkLog_SimCor.txt';
if exist(FileName)~=0
	FileName2=sprintf('Backup_NetwkLog_SimCor_%4d%02d%02d%02d%02d%2.0f.txt',clock);   
	copyfile(FileName,FileName2); 
	delete (FileName);
end

% RawData
DisComp={'Dx(in)','Dy(in)','Dz(in)','Rx(rad)','Ry(rad)','Rz(rad)'};
ForComp={'Fx(kip)','Fy(kip)','Fz(kip)','Mx(kip-in)','My(kip-in)','Mz(kip-in)'};
fname =sprintf('Raw_%s.txt',TestDate_Str);
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	SP_Hori_Top 	SP_Left     	SP_Right    	SP_Hori_Bot 	SP_Front    	');
for i=1:6
	fprintf (fid,'%-12s	',DisComp{i});
end
for i=1:6
	fprintf (fid,'%-12s	',ForComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

% RawMeanData for Elastic Deformation iteration
fname =sprintf('RawMean_AllStep_%s.txt',TestDate_Str);

fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	SP_Hori_Top 	SP_Left     	SP_Right    	SP_Front    	');
for i=1:6
	fprintf (fid,'%-12s	',ForComp{i});
end
for i=1:6
	fprintf (fid,'%-12s	',DisComp{i});
end
for i=1:6
	fprintf (fid,'LBCB %7s	',DisComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

% RawMeanData for Elastic Deformation iteration
fname =sprintf('RawMean_EDStep_%s.txt',TestDate_Str);
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	SP_Hori_Top 	SP_Left     	SP_Right    	SP_Front    	');
for i=1:6
	fprintf (fid,'%-12s	',ForComp{i});
end
for i=1:6
	fprintf (fid,'%-12s	',DisComp{i});
end
for i=1:6
	fprintf (fid,'LBCB %7s	',DisComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

% RawMeanData for Step Reduction
fname =sprintf('RawMean_SRStep_%s.txt',TestDate_Str);
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	SP_Hori_Top 	SP_Left     	SP_Right    	SP_Front    	');
for i=1:6
	fprintf (fid,'%-12s	',ForComp{i});
end
for i=1:6
	fprintf (fid,'%-12s	',DisComp{i});
end
for i=1:6
	fprintf (fid,'LBCB %7s	',DisComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

% RawMeanData for SimCor step
fname =sprintf('RawMean_SimCorStep_%s.txt',TestDate_Str);
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	SP_Hori_Top 	SP_Left     	SP_Right    	SP_Front    	');
for i=1:6
	fprintf (fid,'%-12s	',ForComp{i});
end
for i=1:6
	fprintf (fid,'%-12s	',DisComp{i});
end
for i=1:6
	fprintf (fid,'LBCB %7s	',DisComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

% Tolerance and Increment Limit
fname =sprintf('DispTol_MaxDispIncr_%s.txt',TestDate_Str);
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
TolComp={'Tol_Dx(in)','Tol_Dy(in)','Tol_Dz(in)','Tol_Rx(rad)','Tol_Ry(rad)','Tol_Rz(rad)'};
IncrComp={'Sub_Dx(in)','Sub_Dy(in)','Sub_Dz(in)','Sub_Rx(rad)','Sub_Ry(rad)','Sub_Rz(rad)'};
fprintf (fid,'%%Step	');
for i=1:6
	fprintf (fid,'%-12s	',TolComp{i});
end
for i=1:6
	fprintf (fid,'%-12s	',IncrComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

