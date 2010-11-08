cfg = Configuration;
cfg.load
hfact = HandleFactory([],cfg);
sdf = hfact.sdf;
cdp = ConfigDaoProvider(cfg);
numLbcbs = cdp.numLbcbs();
idx=1;
stps = cell(4,1);

stpNum = StepNumber(0,0,0);

stps{idx} = sdf.stepNumber2StepData(stpNum);
stps{idx}.lbcbCps{1}.command.disp = 1:6;
stps{idx}.lbcbCps{1}.command.dispDofs = ones(6,1);

if numLbcbs > 1
    stps{idx}.lbcbCps{2}.command.force = 1:6;
    stps{idx}.lbcbCps{2}.command.forceDofs = ones(6,1);
end

for i = 1:idx
%    disp(sprintf('Step %d: %s',i,stps{i}.toString()));
end
idx = idx + 1;
stps{idx} = sdf.stepNumber2StepData(stpNum.next(0));
stps{idx}.lbcbCps{1}.command.disp = 1:0.5:3;
stps{idx}.lbcbCps{1}.command.dispDofs = ones(6,1);

if numLbcbs > 1
    stps{idx}.lbcbCps{2}.command.force = 1:2:11;
    stps{idx}.lbcbCps{2}.command.forceDofs = ones(6,1);
end
for i = 1:idx
    disp(sprintf('Step %d: %s',i,stps{i}.toString()));
end
idx = idx + 1;
stps{idx} = sdf.target2StepData({stps{1}.lbcbCps{1}.command,stps{1}.lbcbCps{2}.command},3,2);
stps{idx}.lbcbCps{1}.command.disp = .11:0.1:.61;
stps{idx}.lbcbCps{1}.command.dispDofs = ones(6,1);

if numLbcbs > 1
    stps{idx}.lbcbCps{2}.command.force = 1:3:17;
    stps{idx}.lbcbCps{2}.command.forceDofs = ones(6,1);
end
for i = 1:idx
    disp(sprintf('Step %d: %s',i,stps{i}.toString()));
end
