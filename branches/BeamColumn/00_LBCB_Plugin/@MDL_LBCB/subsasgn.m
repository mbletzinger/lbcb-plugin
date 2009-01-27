function obj = subsasgn(obj,index,val)
% =====================================================================================================================
% Assigning method for Matlab class
%
% Written by    7/21/2006 2:20AM OSK
% =====================================================================================================================

% Make all fields public. Not a wise way, but for now leave as it is.
% Need to improve later.
obj = builtin('subsasgn', obj, index, val);
