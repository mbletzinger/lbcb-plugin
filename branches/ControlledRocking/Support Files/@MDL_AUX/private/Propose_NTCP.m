function TransID = Propose_NTCP(obj)
% =====================================================================================================================
% Propose target displacement to remote site using NTCP protocol
%
%   obj     : A MDL_AUX object representing remote sites
%
% Written by    8/29/2007 2:20AM OSK
% Last updated  8/29/2006 8:40PM OSK
%
% Note: note tested.
% =====================================================================================================================

CPname = cell(length(obj.node),1);  % Control point name
CPdis  = cell(length(obj.node),1);  % Displacement

CPname{1} = sprintf('%s',obj.CPname);         % Set module number as zero. The remote site doesn't need to know.
CPdis{1}(1,:) = {obj.Command{1} obj.Command{2} obj.Command{3}};

try,
    [TransID,MDLAccepted,MDLReason] = propose(obj.Comm_obj,obj.curStep,CPname, CPdis);
catch,
    err = lasterror;
    err.message = ['ERROR proposing CPs to ' obj.name ': ' err.message];
    try,
        cancel(obj.Comm_obj,TransID);
        disp(sprintf('Proposal canceled to %s site', obj.name));
    end;
end;
