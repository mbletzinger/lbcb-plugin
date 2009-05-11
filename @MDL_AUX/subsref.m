function b = subsref(obj,index)
% =====================================================================================================================
% Referencing method for Matlab class
%
% Written by    7/21/2006 2:20AM OSK
% =====================================================================================================================

% Make all fields public. Not a wise way, but for now leave as it is.
% Need to improve later.
b = builtin('subsref', obj, index);

