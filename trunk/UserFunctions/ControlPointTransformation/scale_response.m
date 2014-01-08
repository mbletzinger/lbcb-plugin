function [scaled_disp,scaled_force] = scale_response(scale_factor,mdlTgt)

% Set scaling factor for response, scale from LBCB scale to model

%Initialize
disp = zeros(1,6);
force = zeros(1,6);

for i=1:6
    disp(i) = mdlTgt.disp(i);
    force(i) = mdlTgt.force(i);
end

scaled_disp = disp/scale_factor(1);
scaled_force = force/scale_factor(3);
end    