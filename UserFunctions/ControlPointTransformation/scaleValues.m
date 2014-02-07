function [scaled_values] = scaleValues(scale_factor,values,isInverted)

% Set scaling factor for command, scale from model size to LBCB scale

%Initialize
scale = scale_factor;
if isInverted
	for i = 1:2
		scale(i) = 1/scale_factor(i);
	end
end
%displacement
scaled_values(1:3) = values(1:3)*scale(1);

%rotation
scaled_values(4:6) = disp(4:6)*scale(2);
end    