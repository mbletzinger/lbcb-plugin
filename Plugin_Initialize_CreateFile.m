% script for Plugin_Initialize.m
function Plugin_Initialize_CreateFile;

DateStr=clock;
TestDate_Str=sprintf('%04d%02d%02d%02d%02d',DateStr(1:5));

FileName='LBCB1_RawMean.txt';
if exist(FileName)~=0
	FileName2=sprintf('Backup_LBCB1_RawMean_%4d%02d%02d%02d%02d%2.0f.txt',clock);   
	copyfile(FileName,FileName2); 
	delete (FileName);
end
FileName='LBCB2_RawMean.txt';
if exist(FileName)~=0
	FileName2=sprintf('Backup_LBCB2_RawMean_%4d%02d%02d%02d%02d%2.0f.txt',clock);   
	copyfile(FileName,FileName2); 
	delete (FileName);
end


% RawMeanData for Elastic Deformation iteration LBCB1
DisComp={'Dx(in)','Dy(in)','Dz(in)','Rx(rad)','Ry(rad)','Rz(rad)'};
ForComp={'Fx(kip)','Fy(kip)','Fz(kip)','Mx(kip-in)','My(kip-in)','Mz(kip-in)'};
fname =sprintf('LBCB1_RawMean.txt');
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	4_LBCB1_y_left	5_LBCB1_y_right	6_LBCB1_X	');
for i=1:6
	fprintf (fid,'LBCB_%7s',DisComp{i});
end
for i=1:6
	fprintf (fid,'OM_%9s',DisComp{i});
end
for i=1:6
	fprintf (fid,'OM_%9s',ForComp{i});
end
for i=1:6
    fprintf (fid,'LBCB_TGT_%3s ',DisComp{i});
end
for i=1:6
    fprintf (fid,'MOD_TGT_%4s ',DisComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);

% RawMeanData for Elastic Deformation iteration LBCB2
fname =sprintf('LBCB2_RawMean.txt');
fid = fopen(fname,'w'); % If file exist, this will rewrite the file.
fprintf (fid,'%%Step	1_LBCB2_y	2_LBCB2_x_bot	3_LBCB2_x_top	');
for i=1:6
	fprintf (fid,'LBCB_%7s',DisComp{i});
end
for i=1:6
	fprintf (fid,'OM_%9s',DisComp{i});
end
for i=1:6
	fprintf (fid,'OM_%9s',ForComp{i});
end
for i=1:6
    fprintf (fid,'LBCB_TGT_%3s ',DisComp{i});
end
for i=1:6
    fprintf (fid,'MOD_TGT_%4s ',DisComp{i});
end
fprintf(fid,'\r\n');
fclose(fid);