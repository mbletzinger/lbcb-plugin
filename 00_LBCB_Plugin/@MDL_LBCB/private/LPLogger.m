function LPLogger(str,varargin)
% =====================================================================================================================
% This function saves 'str' on file with filename, 'fname'.
%
%   str     	: Output string
%   varargin{1}	: 1 for data, 2 for network log, 3 for screen
%	varargin{2} : level for screen log
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 8:40PM OSK
% =====================================================================================================================

switch varargin{1}
	case 1
		fid = fopen('NodeDisp.txt','a');
		fprintf(fid,str);
		fclose(fid);
	case 2
		fid = fopen('NetwkLog_LBCB.txt','a');
		
		tmp1 = clock; 			% format to the time output of NTCP mode (for consistency)
		tmp2 = sprintf('%.6f',(tmp1(end)-floor(tmp1(end))));
		tmp1(end) = floor(tmp1(end));
		stamp = sprintf('%s%s \t',datestr(tmp1,0),tmp2(2:end));
		
		fprintf(fid,'%s%s\r\n',stamp,str);
		fclose(fid);
	case 3
		switch varargin{2}
			case 1
		        disp(sprintf('+ %s',str));        % start of level1
		    case 2
		        disp(sprintf('    . %s',str));
		    case 3                              % end of level1
		        disp(sprintf('    o %s',str));
		    case 9                              % Direct output without bullet
		        disp(str);
		end
end