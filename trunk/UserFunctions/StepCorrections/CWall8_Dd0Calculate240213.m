%------------------------------------------------------------------------%
%       C Wall 8 Dd0 Calculate Function
%       Andrew Mock
%       Created May 2012
%       Last edit - Jan 2013 by awmock
%------------------------------------------------------------------------%
%
%Change log:
%  1/16/13 - added distinction for postive and negative Dy cracking
%
%Config variables called in this file:
%  MxCorrectionFactor
%  MyCorrectionFactor
%  FzCorrectionFactor
%  DyCrackingPos
%  DyCrackingNeg
%  SpecimenHeight
%  AlphaEff
%
%Arch variables called in this file:
%  PrevDx
%  (PrevDy) assumed to exist...

function CWall8_Dd0Calculate230213(me,step)
me.log.debug(dbstack,'Running calculate fcn');
%------------------------------------------------------------------------%
%   Get configuration variables and force readings to perform calculations
%------------------------------------------------------------------------%
SAmsr = me.getCfg('MyFxMomentShearRatio'); %Strong Axis Moment to Shear Ratio
%WAmsr = me.getCfg('MxFyMomentShearRatio'); %Weak Axis Moment to Shear Ratio
fx = step.lbcbCps{1}.response.force(1);
fy = step.lbcbCps{1}.response.force(2);
fz = step.lbcbCps{1}.response.force(3);
mmx = step.lbcbCps{1}.response.force(4);
mmy = step.lbcbCps{1}.response.force(5);
mmz = step.lbcbCps{1}.response.force(6);

%check existence of needed configuration variables
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

if me.existsCfg('FzCorrectionFactor')
    cffz = me.getCfg('FzCorrectionFactor');
else
    cffz = 1;
end

%check for first step of protocol
if me.existsArch('PrevDx')  
else
    me.putArch('PrevDx',100)
    me.putArch('PrevDy',100)
    me.putArch('PrevDz',100)
    me.putArch('PrevRx',100)
    me.putArch('PrevRy',100)
    me.putArch('PrevRz',100)
    me.putArch('DirectionX',1)
    me.putArch('DirectionY',1)
end

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
% 2. Calculate base shear of system, V_base
%------------------------------------------------------------------------%

if me.existsCfg('DyCrackingPos')
    y_crack_pos = me.getCfg('DyCrackingPos');
else
    y_crack_pos = 0.04;
end

if me.existsCfg('DyCrackingNeg')
    y_crack_neg = me.getCfg('DyCrackingNeg');
else
    y_crack_neg = 0.04;
end

if me.existsCfg('VbaseCompRatio')
    vbase_comp_ratio = me.getCfg('VbaseCompRatio');
else
    vbase_comp_ratio = 0.35;
end

if me.existsCfg('VbaseTensRatio')
    vbase_tens_ratio = me.getCfg('VbaseTensRatio');
else
    vbase_tens_ratio = 0.65;
end

if me.existsCfg('MbaseCompRatio')
    Mbase_comp_ratio = me.getCfg('MbaseCompRatio');
else
    Mbase_comp_ratio = 0.10;
end

if me.existsCfg('MbaseTensRatio')
    Mbase_tens_ratio = me.getCfg('MbaseTensRatio');
else
    Mbase_tens_ratio = 0.10;
end

V_base_C = fy;
disp = step.lbcbCps{1}.response.ed.disp;    %Specimen (control sensor) dy response
dy = disp(2);

if dy < y_crack_pos				
	if dy > y_crack_neg 
		V_base = V_base_C/0.5; 	%Wall has not cracked in y.  Both Cs in the 
								%coupled core-wall system carry the same shear.
	else
		V_base = V_base_C/vbase_tens_ratio;  %The wall is in tension
	end								
else
        V_base = V_base_C/vbase_comp_ratio;  %The wall is in compression 
end

%------------------------------------------------------------------------%
% 3. Calculate third story moment, M_third
%------------------------------------------------------------------------%
if me.existsCfg('AlphaEff')
    alpha = me.getCfg('AlphaEff');
else
    alpha = 0.71;
end

M_base = alpha*hgt*V_base;      %Base moment of coupled core-wall system
M_third = alpha*M_base;

%------------------------------------------------------------------------%
% 4. Apply moment to top of the specimen
%------------------------------------------------------------------------%
if dy < 0
    M_top_C = Mbase_tens_ratio*M_third;  	%The wall is in tension
else
    M_top_C = Mbase_comp_ratio*M_third;     %The wall is in compression
end

%------------------------------------------------------------------------%
% 5. Determine axial load
%------------------------------------------------------------------------%
Lcouple = me.getCfg('CoupleLength');
fc = me.getCfg('CompressiveStrengthfc');
Ag = me.getCfg('GrossArea');
BeamWeight = me.getCfg('BeamWeight');
if dy < 0
    P_C = 0.8*M_third/Lcouple + 0.05*fc*Ag - BeamWeight;	%Wall is in tension
else
    P_C = 0.8*M_third/Lcouple + 0.05*fc*Ag - BeamWeight;     %Wall is in compression
end

%------------------------------------------------------------------------%
%Calculate moment for current shear force and moment to shear ratio
%------------------------------------------------------------------------%
cmx = M_top_C;
cmy = fx * SAmsr;

%------------------------------------------------------------------------%
%Calculate differnce between current moment and target moment
%------------------------------------------------------------------------%
correction_mx = cmx - mmx;
correction_my = cmy - mmy;
correction_fz = P_C - fz;
%------------------------------------------------------------------------%
%Set proposed moment values = current moment + change in moment * reduction factor
%------------------------------------------------------------------------%
pmx = mmx + correction_mx * cfmx;
pmy = mmy + correction_my * cfmy;
pfz = fz + correction_fz * cffz;

%------------------------------------------------------------------------%
%Output proposed and measured moment values
%------------------------------------------------------------------------%
me.putArch('CalculatedMx',cmx);
me.putArch('ProposedMx',pmx);
me.putArch('MeasuredMx',mmx);
me.putArch('CalculatedMy',cmy);
me.putArch('ProposedMy',pmy);
me.putArch('MeasuredMy',mmy);
me.putArch('ProposedFz',pfz);
me.putArch('MeasuredFz',fz);
me.putArch('MeasuredFx',fx);
me.putArch('MeasuredFy',fy);
me.putArch('MeasuredMz',mmz);
me.putArch('System_BaseShear',V_base);
me.putArch('System_BaseMoment',M_base);
me.putArch('System_ThirdStoryMoment',M_third);
me.putArch('C_BaseShear',V_base_C);
me.putArch('C_ThirdStoryMoment',M_top_C);
me.putArch('C_AxialLoad',P_C);


%------------------------------------------------------------------------%
%Output moment to shear ratios
%------------------------------------------------------------------------%
mm2sx=mmy/fx;
mm2sy=mmx/fy;
me.putArch('MeasuredMoment2ShearX',mm2sx)
me.putArch('MeasuredMoment2ShearY',mm2sy)

WAmsr = pmx/fy;
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
str = sprintf('%s   \n',str);
str = sprintf('%s   Coupled Wall Simulation Output:\n',str);
str = sprintf('%s   Specimen axial load = %f, Specimen third story moment = %f\n',str,P_C,M_top_C);
str = sprintf('%s   System base shear = %f, System base moment = %f, System third story moment = %f\n',str,V_base,M_base,M_third);
me.log.debug(dbstack,str);

end