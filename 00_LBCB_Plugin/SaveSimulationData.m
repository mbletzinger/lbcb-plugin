function SaveSimulationData (SaveFileName,Step_Num,SaveData,varargin)
%----------------------------------------------------------------------------------------
% SaveFileName: 
%    varargin{1}==1: 'Raw.txt', 'RawMean_SimCorStep.txt', 'RawMean_EDStep.txt'
%                    'RawMean_SRStep.txt', 'RawMean_AllStep.txt'
%    varargin{1}==2: 'DispTol_MaxDispIncr.txt'
%
%----------------------------------------------------------------------------------------
if varargin{1}==1
	fid = fopen(SaveFileName,'a');
	fprintf(fid,'%5.0f	',Step_Num);
	for i=1:length (SaveData)
		fprintf(fid,'%+12.7e	',SaveData(i));
	end
	fprintf(fid,'\r\n');
	fclose(fid);

elseif varargin{1}==2
	fid = fopen(SaveFileName,'a');
	%SJKIM Nov28-2007
	fprintf(fid,'%5.0f	',Step_Num);
	for i=1:length (SaveData)
		fprintf(fid,'%+12.7e	',SaveData(i));
	end  
	if varargin{2}==1 
		fprintf(fid,'%s	',varargin{3});
	end
	fprintf(fid,'\r\n');
	fclose(fid);
end
