function [scaled_disp_1,scaled_disp_2,scaled_force_1,scaled_force_2] = scale_response(scale_factor,mdlTgts)

% Set scaling factor for response, scale from LBCB scale to model

%Initialize
disp_1 = zeros(1,6);
disp_2 = zeros(1,6);
force_1 = zeros(1,6);
force_2 = zeros(1,6);

for i=1:6
    disp_1(i) = mdlTgts{1}.disp(i);
    disp_2(i) = mdlTgts{2}.disp(i);
    force_1(i) = mdlTgts{1}.force(i);
    force_2(i) = mdlTgts{2}.force(i);
end

scaled_disp_1 = disp_1/scale_factor(1);
scaled_disp_2 = disp_2/scale_factor(1);
scaled_force_1 = force_1/scale_factor(3);
scaled_force_2 = force_2/scale_factor(3);
end    