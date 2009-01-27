function TriggerDAQ(obj,stepno,sbstepno)
% =====================================================================================================================
% 
% DAQ Trigger
%
% =====================================================================================================================

for i=1
	obj(i).curStep= obj(i).curStep + 1;
		if obj(i).Initialized
			obj(i) = proposeDAQ(obj(i),stepno,sbstepno);
        end
end