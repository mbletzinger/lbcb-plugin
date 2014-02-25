function scaled_values = scaleValues(scale_factor,values,isInverted)

% Set scaling factor for command, scale from model size to LBCB scale
scaled_values = zeros(6,1);
%Initialize
scale = scale_factor;
if isInverted
	for i = 1:3
		scale(i) = 1/scale_factor(i);
	end
end
%displacement
scaled_values(1:3) = values(1:3).*scale(1:3);

%rotation
scaled_values(4:6) = values(4:6)*scale(4);
end    
