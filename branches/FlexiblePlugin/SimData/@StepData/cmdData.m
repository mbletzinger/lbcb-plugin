function [ disp dDofs force fDofs] = cmdData(me)
if cdp.numLbcbs == 1
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


disp(1:6) = me.lbcbCps{1}.command.disp;
dDofs(1:6) = me.lbcbCps{1}.command.dispDofs;
force(1:6) = me.lbcbCps{1}.command.force;
fDofs(1:6) = me.lbcbCps{1}.command.forceDofs;

if cdp.numLbcbs > 1
    disp(7:12) = me.lbcbCps{2}.command.disp;
    dDofs(7:12) = me.lbcbCps{2}.command.dispDofs;
    force(1:6) = me.lbcbCps{2}.command.force;
    fDofs(1:6) = me.lbcbCps{2}.command.forceDofs;
end
end