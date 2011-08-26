function test_suite = testOmConfigDao
initTestSuite;

function test_OmConfigDao

clearSpace
cfg = Configuration;
cfg.loadFile('UnitTests\unittest_properties.properties');
ocfg = OmConfigDao(cfg);

result = ocfg.dt.getInt('om.numLbcbs',1);
assertEqual(2,result)

value = 1;
ocfg.dt.setInt('om.numLbcbs',value);
result = ocfg.dt.getInt('om.numLbcbs',1);
assertEqual(1,result)

result = ocfg.dt.getInt('om.numExtSensors',0);
assertEqual(6,result)

value = 4;
ocfg.dt.setInt('om.numExtSensors',value);
result = ocfg.dt.getInt('om.numExtSensors',0);
assertEqual(4,result)

value = 6;
ocfg.dt.setInt('om.numExtSensors',value);
result = ocfg.dt.getInt('om.numExtSensors',0);
assertEqual(6,result)

result = ocfg.dt.getBool('om.useFakeOm',0);
assertEqual(0,result)

value = 1;
ocfg.dt.setBool('om.useFakeOm',value);
result = ocfg.dt.getBool('om.useFakeOm',0);
assertEqual(1,result)

result = ocfg.dt.getStringVector('om.sensorNames',{''});
str = {'1_LBCB1_h';'2_LBCB1_vl';'3_LBCB1_vr';'6_LBCB2_v';'4_LBCB2_ht';'5_LBCB2_hb'};
assertEqual(str,result)

value = {'1_LBCB1_v';'2_LBCB1_hl';'3_LBCB1_hr';'6_LBCB2_h';'4_LBCB2_vt';'5_LBCB2_vb'};
ocfg.dt.setStringVector('om.sensorNames',value);
result = ocfg.dt.getStringVector('om.sensorNames',{''});
str = {'1_LBCB1_v';'2_LBCB1_hl';'3_LBCB1_hr';'6_LBCB2_h';'4_LBCB2_vt';'5_LBCB2_vb'};
assertEqual(str,result)

result = ocfg.dt.getStringVector('om.apply2Lbcb',{'BOTH'});
str = {'LBCB1';'LBCB1';'LBCB1';'LBCB2';'LBCB2';'LBCB2'};
assertEqual(result,str)

value = {'LBCB2';'LBCB1';'LBCB2';'LBCB1';'BOTH';'BOTH'};
ocfg.dt.setStringVector('om.apply2Lbcb',value);
result = ocfg.dt.getStringVector('om.apply2Lbcb',{'BOTH'});
str = {'LBCB2';'LBCB1';'LBCB2';'LBCB1';'BOTH';'BOTH'};
assertEqual(result,str)

result = ocfg.dt.getDoubleVector('om.sensitivities',[1]);
om_sens = ones(6,1);
assertEqual(om_sens,result)

value = 2*ones(6,1);
ocfg.dt.setDoubleVector('om.sensitivities',value);
result = ocfg.dt.getDoubleVector('om.sensitivities',[1]);
om_sens = 2*ones(6,1);
assertEqual(om_sens,result)

sz = ocfg.numExtSensors;
result = ocfg.dt.getTransVector('om.location.base','ext.sensor',sz);
location_base = [result{1},result{2},result{3},result{4},result{5},result{6}];
baseloaction = [-120.8438,-50.5938,27.2812,1.2500,-38.1250,-47.8750;-0.2813,-0.5313,0.0312,0,0.7500,0.2500;2.7814,50.5939,32.3439,141.3750,-38.9375,47.8750];
assertEqual(baseloaction,location_base)

% value = [-121.8438,-51.5938,28.2812,2.2500,-39.1250,-48.8750;-1.2813,-1.5313,1.0312,1,1.7500,1.2500;3.7814,51.5939,33.3439,142.3750,-39.9375,48.8750];
% a{1} = [-121.8438;-1.2813;3.7814];
% a{2} = [-51.5938;-1.5313;51.5939];
% a{3} = [28.2812;1.0312;33.3439];
% a{4} = [2.2500;1;142.3750];
% a{5} = [-39.1250;1.7500;-39.9375];
% a{6} = [-48.8750;1.2500;48.8750];
% value = [a{1},a{2},a{3},a{4},a{5},a{6}];
sz = ocfg.numExtSensors;
value = ocfg.dt.getTransVector('om.location.base','ext.sensor',sz);
value{1} = value{1} + ones(3,1);
value{2} = value{2} + ones(3,1);
value{3} = value{3} + ones(3,1);
value{4} = value{4} + ones(3,1);
value{5} = value{5} + ones(3,1);
value{6} = value{6} + ones(3,1);
sz = length(value);
ocfg.dt.setTransVector('om.location.base','ext.sensor',sz,value);
result = ocfg.dt.getTransVector('om.location.base','ext.sensor',sz);
location_base = [result{1},result{2},result{3},result{4},result{5},result{6}];
baseloaction = [-120.8438,-50.5938,27.2812,1.2500,-38.1250,-47.8750;-0.2813,-0.5313,0.0312,0,0.7500,0.2500;2.7814,50.5939,32.3439,141.3750,-38.9375,47.8750] + ones(3,6);
assertEqual(baseloaction,location_base)

sz = ocfg.numExtSensors;
result = ocfg.dt.getTransVector('om.location.plat','ext.sensor',sz);
location_plat = [result{1},result{2},result{3},result{4},result{5},result{6}];
platloaction = [  -57.9688  -51.7188   31.9062    2.1250   -2.8750   -3.8125;   -0.1563   -0.2188    0.0312    2.3750    3.1250    2.6250;    1.7814    5.4064    5.7814   52.4375  -39.0625   46.3125];
assertEqual(platloaction,location_plat)

% value = [  -58.9688  -52.7188   32.9062    3.1250   -3.8750   -4.8125;   -1.1563   -1.2188    1.0312    3.3750    4.1250    3.6250;    2.7814    6.4064    6.7814   53.4375  -40.0625   47.3125];
sz = ocfg.numExtSensors;
value = ocfg.dt.getTransVector('om.location.plat','ext.sensor',sz);
value{1} = value{1} + ones(3,1);
value{2} = value{2} + ones(3,1);
value{3} = value{3} + ones(3,1);
value{4} = value{4} + ones(3,1);
value{5} = value{5} + ones(3,1);
value{6} = value{6} + ones(3,1);
sz = length(value);
ocfg.dt.setTransVector('om.location.plat','ext.sensor',sz,value);
result = ocfg.dt.getTransVector('om.location.plat','ext.sensor',sz);
location_plat = [result{1},result{2},result{3},result{4},result{5},result{6}];
platloaction = [  -57.9688  -51.7188   31.9062    2.1250   -2.8750   -3.8125;   -0.1563   -0.2188    0.0312    2.3750    3.1250    2.6250;    1.7814    5.4064    5.7814   52.4375  -39.0625   46.3125] + ones(3,6);
assertEqual(platloaction,location_plat)

result = ocfg.dt.getDoubleVector('om.sensor.error.tol',[0]);
error_tol = 1.0e-004*ones(6,1);
assertEqual(error_tol,result)

value = 1.0e-005*ones(6,1);
ocfg.dt.setDoubleVector('om.sensor.error.tol',value);
result = ocfg.dt.getDoubleVector('om.sensor.error.tol',[0]);
error_tol = 1.0e-005*ones(6,1);
assertEqual(error_tol,result)

result = ocfg.dt.getTarget('om.sensor.perturbations.lbcb1');
displacements = result.disp;
Forces = result.force;
t_disp = [0.01;0;0.01;0;0.0002;0];
t_force = zeros(6,1);
assertEqual(t_disp,displacements)
assertEqual(t_force,Forces)

value = ocfg.dt.getTarget('om.sensor.perturbations.lbcb1');
value.disp = 2*value.disp;
value.force = value.force + ones(6,1);
value.forceDofs = ones(6,1);
ocfg.dt.setTarget('om.sensor.perturbations.lbcb1',value);
result = ocfg.dt.getTarget('om.sensor.perturbations.lbcb1');
displacements = result.disp;
Forces = result.force;
t_disp = 2*[0.01;0;0.01;0;0.0002;0];
t_force = ones(6,1);
assertEqual(t_disp,displacements)
assertEqual(t_force,Forces)
