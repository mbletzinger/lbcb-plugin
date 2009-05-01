clear all; close all; clc

MDL 		= MDL_RF;
MDL.URL         = '127.0.0.1:11998';        % URL of the remote site
MDL.name 	= 'Connection'; % Module ID of this module is 1
MDL.protocol 	= 'labview2';
MDL.node    	= [1 2 3];           % Control point node number
MDL.EFF_DOF 	= [1 1 0 0 0 1   % Effective DOF for CP 1
                   1 1 0 0 0 1   % Effective DOF for CP 1
                   1 1 0 0 0 1]; % Effective DOF for CP 1
MDL.EnableGUI   = 0;


MDL 		= initialize(MDL);
MDL 		= open(MDL);
k = zeros(9,9)

pause;

for i=1:9
    TGTD{1}         = [0 0 0   0 0 0   0 0 0]'; %'
    TGTD{1}(i) = .001;
    MDL		= propose(MDL,TGTD);
    MDL		= execute(MDL);
    MDL		= query(MDL);				% only displacements are valid. 
    k(:,i) = MDL.M_Forc;
    MDL.M_Forc'
end


pause;

%tic;
%for i=1:100
%	TGTD{1}         = [1 2 3   4 5 6   7 8 9]'*.001; %'
%	MDL		= propose(MDL,TGTD);
%	MDL		= execute(MDL);
%	MDL		= query(MDL);				% only displacements are valid. 
%	ActStroke 	= MDL.M_Disp(1) - MDL.M_Disp(2);
%	SpecimDispl	= MDL.M_Disp(1);
%	ElastDeform   	= MDL.M_Disp(2);
%end
%toc
%
%
%close(MDL);