function [ disp force] = respData(me)
if me.cdp.numLbcbs == 1
    disp = zeros(6,1);
    force = zeros(6,1);
else
    disp = zeros(12,1);
    force = zeros(12,1);
end


[ disp(1:6) force(1:6) ] = me.lbcbCps{1}.respData();

if me.cdp.numLbcbs > 1
    [ disp(7:12) force(7:12) ] = me.lbcbCps{2}.respData();
end
end