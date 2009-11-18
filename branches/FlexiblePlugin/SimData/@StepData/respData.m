function [ disp force] = respData(me)
if cdp.numLbcbs == 1
    disp = zeros(6,1);
    force = zeros(6,1);
else
    disp = zeros(12,1);
    force = zeros(12,1);
end


disp(1:6) = me.lbcbCps{1}.command.disp;
force(1:6) = me.lbcbCps{1}.command.force;

if cdp.numLbcbs > 1
    disp(7:12) = me.lbcbCps{2}.command.disp;
    force(1:6) = me.lbcbCps{2}.command.force;
end
end