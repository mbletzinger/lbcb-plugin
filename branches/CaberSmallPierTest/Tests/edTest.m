% Load up Java libraries
JavaTest

% load test configuration
cfg = Configuration;
cfgpath = fullfile(pwd,'Tests','edTest.properties');
cfg.loadFile(cfgpath);
OmConfig('cfg',cfg);
lcfg.cmdLevel = 'DEBUG';
lcfg.msgLevel = 'INFO';
Logger.setCmdLevel(lcfg.cmdLevel);
Logger.setMsgLevel(lcfg.msgLevel);
cfg.saveFile(cfgpath);
cdp = ConfigDaoProvider(cfg);
% Create input file
d_targets = [0        0       0           
             0        0.25    0           
             0.1      0.15    7.62e-3     
             0.1      0.15    7.62e-3     
             0.5      0.05    3.5e-2      
             0        0       0           
             -10      -1      -7.62e-2    
             10       1       7.62e-2     
             0        0       0           ];
       
ed = ElasticDeformation(cdp,1);

[numTargets, dummy] = size(d_targets);
plcp = [];

for t = 1:numTargets
    lcp = LbcbControlPoint;
    lcp.response.cdp = cdp;
    lcp.externalSensors = d_targets(t,:);
    ed.calculate(lcp,plcp);
    lcp.toString()
    plcp = lcp;
end

