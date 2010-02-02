function [scaled_disp_1,scaled_disp_2] = scale_command(scale_factor,lbcbTgts)

% Set scaling factor for command, scale from model size to LBCB scale

%Initialize
disp_LBCB_1 = zeros(1,6);
disp_LBCB_2 = zeros(1,6);

for i=1:6
    disp_LBCB_1(i) = lbcbTgts{1}.disp(i);
    disp_LBCB_2(i) = lbcbTgts{2}.disp(i);
end

scaled_disp_1 = disp_LBCB_1*scale_factor(1);
scaled_disp_2 = disp_LBCB_2*scale_factor(1);

end    