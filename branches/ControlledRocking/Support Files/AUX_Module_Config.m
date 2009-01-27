0%------------------------------------------------------------------------------------
% Auxiliary module configuration
%------------------------------------------------------------------------------------
Num_Aux = 3;

% DAQ Computer
AUX(1).URL            = '130.126.241.8:5057';
AUX(1).protocol       = 'LabView1';                       
AUX(1).name           = 'DAQ';     % Module ID of this mdoule is 1    
AUX(1).Command        = {'displacement' 'z' 3500};

% Camera Computer #1
AUX(2).URL            = '130.126.242.140:21998';
AUX(2).protocol       = 'LabView1';                       
AUX(2).name           = 'Camera1';     % Module ID of this mdoule is 1    
AUX(2).Command        = {'displacement' 'z' 3500}; 

% Camera Computer #2
AUX(3).URL            = '130.126.243.197:21998';
AUX(3).protocol       = 'LabView1';                       
AUX(3).name           = 'Camera2';     % Module ID of this mdoule is 1    
AUX(3).Command        = {'displacement' 'z' 3500}; 