% Load up Java libraries
JavaTest

% load test configuration
cfg = Configuration;
cfgpath = fullfile(pwd,'Tests','edTest.properties');
cfg.loadFile(cfgpath);
OmConfig('cfg',cfg);
cfg.saveFile(cfgpath);
cdp = ConfigDaoProvider(cfg);
% Create input file
d_targets = [0        0     0       0   0           0
             0        0     0.25    0   0           0
             0.1      0     0.15    0   7.62e-3     0
             0.1      0     0.15    0   7.62e-3     0
             0.5      0     0.05    0   3.5e-2      0
             0        0     0       0   0           0
             -10      0     -1      0   -7.62e-2    0
             10       0     1       0   7.62e-2     0
             0        0     0       0   0           0];
       
ed = ElasticDeformation(cdp,1);

[numTargets, dummy] = size(d_targets);
plcp = LbcbControlPoint;
plcp.response.cdp = cdp;

for t = 1:numTargets
    lcp = LbcbControlPoint;
    lcp.response.cdp = cdp;
    lcp.externalSensors = d_targets(t,:);
    ed.calculate(lcp,plcp);
    lcp.toString()
end

