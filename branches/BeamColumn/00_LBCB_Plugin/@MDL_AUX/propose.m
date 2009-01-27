function obj = propose(obj, TGTD)
% =====================================================================================================================
% This method propose target displacement to remote site.
%
% Input:
%       obj     : object of MDL_RF class
%       TGTD    : a vector with dimension, Num_DOF x 1
%
% Output:
%       obj     : updated object of MDL_RF class
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 2:20AM OSK
% =====================================================================================================================

for i=1:length(obj)
    % Send target displacement to remote site ------------------------------------------------------------------------------
    switch lower(obj(i).protocol)
        case 'ntcp'
            obj(i).TransID = Propose_NTCP(obj(i));
        case 'labview1'
            obj(i).TransID = Propose_LabView(obj(i));
        otherwise
    end
end
