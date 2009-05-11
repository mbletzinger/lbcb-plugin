function errmsg(str)
% =====================================================================================================================
% This private function send formatted error message to screen.
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 2:20AM OSK
% =====================================================================================================================

dispmsg(str);
rethrow(lasterror);