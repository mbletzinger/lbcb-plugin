function TriggerCAM(obj)
% =====================================================================================================================
% 
% Camera Trigger
%
% =====================================================================================================================

for i=2:length(obj)
	obj(i).curStep= obj(i).curStep + 1;
		if obj(i).Initialized
			obj(i) = propose(obj(i));
        end
end