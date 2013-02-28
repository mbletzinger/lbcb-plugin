%------------------------------------------------------------------------%
%       C Wall 7 Dd0 Calculate Function
%       Andrew Mock
%       Created May 2012
%       Last edit - June 5, 2012 by amock
%------------------------------------------------------------------------%
function CWall7_Dd0Calculate(me,step)
me.log.debug(dbstack,'Running calculate fcn');
%------------------------------------------------------------------------%
%   Get configuration variables and force readings to perform calculations
%------------------------------------------------------------------------%
SAmsr = me.getCfg('MyFxMomentShearRatio'); %Strong Axis Moment to Shear Ratio
WAmsr = me.getCfg('MxFyMomentShearRatio'); %Weak Axis Moment to Shear Ratio
fx = step.lbcbCps{1}.response.force(1);
fy = step.lbcbCps{1}.response.force(2);
mmx = step.lbcbCps{1}.response.force(4);
mmy = step.lbcbCps{1}.response.force(5);

if me.existsCfg('MxCorrectionFactor')
    cfmx = me.getCfg('MxCorrectionFactor');
else
    cfmx = 1;
end

if me.existsCfg('MyCorrectionFactor')
    cfmy = me.getCfg('MyCorrectionFactor');
else
    cfmy = 1;
end

%------------------------------------------------------------------------%
%Calculate moment for current shear force and moment to shear ratio
%------------------------------------------------------------------------%
cmx = fy * WAmsr;
cmy = fx * SAmsr;

%------------------------------------------------------------------------%
%Calculate differnce between current moment and target moment
%------------------------------------------------------------------------%
correction_mx = cmx - mmx;
correction_my = cmy - mmy;


%------------------------------------------------------------------------%
%Set proposed moment values = current moment + change in moment * reduction factor
%------------------------------------------------------------------------%
pmx = mmx + correction_mx * cfmx;
pmy = mmy + correction_my * cfmy;

%------------------------------------------------------------------------%
%Output proposed and measured moment values
%------------------------------------------------------------------------%
me.putArch('ProposedMx',pmx)
me.putArch('MeasuredMx',mmx)
me.putArch('ProposedMy',pmy)
me.putArch('MeasuredMy',mmy)

%------------------------------------------------------------------------%
%Output total applied moments at base of wall
%------------------------------------------------------------------------%
if me.existsCfg('SpecimenHeight')
    hgt = me.getCfg('SpecimenHeight');
else
    hgt = 144;
end

myBot = mmy - hgt * fx;
mxBot = mmx + hgt * fy;
me.putArch('MxBot',mxBot)
me.putArch('MyBot',myBot)

%------------------------------------------------------------------------%
%Output moment to shear ratios
%------------------------------------------------------------------------%
mm2sx=mmy/fx;
mm2sy=mmx/fy;
me.putArch('MeasuredMoment2ShearX',mm2sx)
me.putArch('MeasuredMoment2ShearY',mm2sy)

%------------------------------------------------------------------------%
%Output calculations to Plugin log file for debugging and record
%------------------------------------------------------------------------%
str = sprintf(' \n');
str = sprintf('%s   fx = %f\n',str,step.lbcbCps{1}.response.force(1));
str = sprintf('%s   My moment correction factor = %f\n',str,cfmy);
str = sprintf('%s   Dd0 calculated My = %f, measured My = %f, proposed My = %f\n',str,cmy,mmy,pmy);
str = sprintf('%s   Strong Axis proposed Moment to Shear = %f, actual Moment to Shear = %f\n',str,SAmsr,mm2sx);
str = sprintf('%s   fy = %f\n',str,step.lbcbCps{1}.response.force(2));
str = sprintf('%s   Mx moment correction factor = %f\n',str,cfmx);
str = sprintf('%s   Dd0 calculated Mx = %f, measured Mx = %f, proposed Mx = %f\n',str,cmx,mmx,pmx);
str = sprintf('%s   Weak axis proposed Moment to Shear = %f, actual Moment to Shear = %f\n',str,WAmsr,mm2sy);
me.log.debug(dbstack,str);

end