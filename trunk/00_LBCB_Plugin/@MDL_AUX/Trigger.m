function Trigger(obj)
% =====================================================================================================================
% Trigger camera
%
% Written by    7/21/2006 2:20AM OSK
% =====================================================================================================================
for i=1:length(obj)
	obj(i).curStep= obj(i).curStep + 1;
	
%	if (obj(i).curStep >= obj(i).birth_step)	% if current step is larger than birth step 
		if obj(i).Initialized
			obj(i) = propose(obj(i));
	%		obj(i) = execute(obj(i));
		end
%	end
end