javaaddpath(fullfile(pwd,'JavaLibrary','UiSimCorJava-1.0.1-SNAPSHOT.jar'));
javaaddpath(fullfile(pwd,'JavaLibrary','log4j-1.2.15.jar'));
javaaddpath(fullfile(pwd,'JavaLibrary'));
javaaddpath(fullfile(pwd,'JavaLibrary','log4j.properties'));
lprops = org.apache.log4j.PropertyConfigurator;
lprops.configure(fullfile('JavaLibrary','log4j.properties'));
% tester=org.nees.uiuc.simcor.matlab.test.MatlabTester;
% methodsview 'org.nees.uiuc.simcor.transaction.TransactionFactory'
