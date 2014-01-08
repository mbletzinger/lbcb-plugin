function [scaled_disp] = scale_command(scale_factor,lbcbTgt)

% Set scaling factor for command, scale from model size to LBCB scale

%Initialize
disp_LBCB = zeros(6,1);
scaled_disp = zeros(6,1);

for i=1:6
    disp_LBCB(i) = lbcbTgt.disp(i);
end

%displacement
scaled_disp(1:3) = disp_LBCB(1:3)*scale_factor(1);

%rotation
scaled_disp(4:6) = disp_LBCB(4:6)*scale_factor(2);
end    