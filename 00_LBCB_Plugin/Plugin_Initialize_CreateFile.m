% script for Plugin_Initialize.m

FileName='NetwkLog_LBCB.txt';
if exist(FileName)~=0
	delete ('NetwkLog_LBCB.txt');
end
FileName='NetwkLog_SimCor.txt';
if exist(FileName)~=0
	delete ('NetwkLog_SimCor.txt');
end
% RawData
DisComp={'Dx(in)','Dy(in)','Dz(in)','Rx(rad)','Ry(rad)','Rz(rad)'};
ForComp={'Fx(kip)','Fy(kip)','Fz(kip)','Mx(kip-in)','My(kip-in)','Mz(kip-in)'};
fname ='Raw.txt';
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

% RawMeanData
fname ='RawMean.txt';
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

