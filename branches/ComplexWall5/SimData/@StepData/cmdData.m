function [ disp dDofs force fDofs] = cmdData(me)
if me.cdp.numLbcbs == 1
    disp = zeros(6,1);
    dDofs = zeros(6,1);
    force = zeros(6,1);
    fDofs = zeros(6,1);
else
    disp = zeros(12,1);
    dDofs = zeros(12,1);
    force = zeros(12,1);
    fDofs = zeros(12,1);
end


[ disp(1:6) dDofs(1:6) force(1:6) fDofs(1:6) ]  = me.lbcbCps{1}.cmdData;

if me.cdp.numLbcbs > 1
[ disp(7:12) dDofs(7:12) force(7:12) fDofs(7:12) ]  = me.lbcbCps{2}.cmdData;
end
end