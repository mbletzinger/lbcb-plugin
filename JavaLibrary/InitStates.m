% =====================================================================================================================
% Function which initialize cell arrays to match the enum data types found in the SimCorTcp library.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
function init = InitStates()
% This array needs to match
% org.nees.uiuc.simcor.transaction.Transaction.TransactionStateNames
enums = org.nees.uiuc.simcor.states.TransactionStateNames.values();

init.transactionStates = cell(enums.length,1);

for i = 1:enums.length
    init.transactionStates{i} = char(enums(i)); 
end
% This array needs to match
% org.nees.uiuc.simcor.tcp.Connection.ConnectionState
init.connectionStates = {'READY','BUSY','IN_ERROR','CLOSED'};

% This array needs to match org.nees.simcor.transaction.SimCorMsg.MsgType
init.msgTypes = {'COMMAND', 'NOT_OK_RESPONSE', 'OK_RESPONSE'};
end