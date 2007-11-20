% _________________________________________________________________________________________________
%
% Auxiliary module configuration
% _________________________________________________________________________________________________

Num_Aux = 3;
%AUX(1)                = handles.AUX ;
AUX(1).URL            = '130.126.243.197:21999';
AUX(1).protocol       = 'LabView1';                       
AUX(1).name           = 'Camera1';     % Module ID of this mdoule is 1    
AUX(1).Command        = {'displacement' 'z' 3500}; 

AUX(2).URL            = '130.126.242.163:21998';
AUX(2).protocol       = 'LabView1';                       
AUX(2).name           = 'Camera2';     % Module ID of this mdoule is 1    
AUX(2).Command        = {'displacement' 'z' 3500}; 

%AUX(3).URL            = '130.126.241.218:21997';
%AUX(3).protocol       = 'LabView1';                       
%AUX(3).name           = 'Camera3';     % Module ID of this mdoule is 1    
%AUX(3).Command        = {'displacement' 'z' 3500}; 

AUX(3).URL            = '130.126.242.140:5057';
AUX(3).protocol       = 'LabView1';                       
AUX(3).name           = 'DAQ';     % Module ID of this mdoule is 1    
AUX(3).Command        = {'displacement' 'z' 3500}; 

