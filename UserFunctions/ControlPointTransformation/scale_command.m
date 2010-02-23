function [scaled_disp_1,scaled_disp_2] = scale_command(scale_factor,lbcbTgts)

% Set scaling factor for command, scale from model size to LBCB scale

%Initialize
disp_LBCB_1 = zeros(1,6);
disp_LBCB_2 = zeros(1,6);
scaled_disp_1 = zeros(1,6);
scaled_disp_2 = zeros(1,6);

for i=1:6
    disp_LBCB_1(i) = lbcbTgts{1}.disp(i);
    disp_LBCB_2(i) = lbcbTgts{2}.disp(i);
end

%displacement
scaled_disp_1(1:3) = disp_LBCB_1(1:3)*scale_factor(1);
scaled_disp_2(1:3) = disp_LBCB_2(1:3)*scale_factor(1);

%rotation
scaled_disp_1(4:6) = disp_LBCB_1(4:6)*scale_factor(2);
scaled_disp_2(4:6) = disp_LBCB_2(4:6)*scale_factor(2);

end    