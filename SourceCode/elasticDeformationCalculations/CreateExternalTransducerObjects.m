function [allExtTrans,lbcbGeos,params] = CreateExternalTransducerObjects()
lbcbGeos = cell(2,1);
config = ConfigExternalTransducers();
allExtTrans = allExternalTransducers(config.AllNames);
allExtTrans.sensitivities = config.Sensitivities;
allExtTrans.initialLengths = config.InitialLength;

params = ElasticDeformationParameters();
params.tolerance = config.Params.TOL;
params.pertD = [config.Params.Dx config.Params.Dz  config.Params.Ry];

lbcbGeos{1} = lbcbExternalTransducerGeometry();
lbcbGeos{1}.setSensorBounds(config.Lbcb1.IdxBounds);
lbcbGeos{1}.base = config.Lbcb1.Base;
lbcbGeos{1}.plat = config.Lbcb1.Plat;
lbcbGeos{1}.motionCenter2SpecimanOffset = config.Lbcb1.Off_SPCM;
lbcbGeos{1}.motionCenterXfrm = config.Lbcb1.McTransform;
lbcbGeos{1}.motionCenter2LbcbOffset = config.Lbcb1.Off_MCTR;

lbcbGeos{2} = lbcbExternalTransducerGeometry();
lbcbGeos{2}.setSensorBounds(config.Lbcb2.IdxBounds);
lbcbGeos{2}.base = config.Lbcb2.Base;
lbcbGeos{2}.plat = config.Lbcb2.Plat;
lbcbGeos{2}.motionCenter2SpecimanOffset = config.Lbcb2.Off_SPCM;
lbcbGeos{2}.motionCenterXfrm = config.Lbcb2.McTransform;
lbcbGeos{2}.motionCenter2LbcbOffset = config.Lbcb2.Off_MCTR;

end