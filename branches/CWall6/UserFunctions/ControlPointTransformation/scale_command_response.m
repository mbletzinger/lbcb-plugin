function [scaled_disp_1,scaled_disp_2,scaled_force_1,scaled_force_2] = scale_command_response(scale_factor,lbcbTgts)

% Set scaling factor for command, scale from model size to LBCB scale

%Initialize
disp_LBCB_1 = zeros(6,1);
disp_LBCB_2 = zeros(6,1);
force_LBCB_1 = zeros(6,1);
force_LBCB_2 = zeros(6,1);
scaled_disp_1 = zeros(6,1);
scaled_disp_2 = zeros(6,1);
scaled_force_1 = zeros(6,1);
scaled_force_2 = zeros(6,1);

for i=1:6
    disp_LBCB_1(i) = lbcbTgts{1}.disp(i);
    disp_LBCB_2(i) = lbcbTgts{2}.disp(i);
    force_LBCB_1(i) = lbcbTgts{1}.force(i);
    force_LBCB_2(i) = lbcbTgts{2}.force(i);
end

%displacement
scaled_disp_1(1:3) = disp_LBCB_1(1:3)/scale_factor(1);
scaled_disp_2(1:3) = disp_LBCB_2(1:3)/scale_factor(1);

%rotation
scaled_disp_1(4:6) = disp_LBCB_1(4:6)/scale_factor(2);
scaled_disp_2(4:6) = disp_LBCB_2(4:6)/scale_factor(2);

%force
scaled_force_1(1:3) = force_LBCB_1(1:3)/scale_factor(3);
scaled_force_2(1:3) = force_LBCB_2(1:3)/scale_factor(3);

%moment
scaled_force_1(4:6) = force_LBCB_1(4:6)/scale_factor(4);
scaled_force_2(4:6) = force_LBCB_2(4:6)/scale_factor(4);

end    