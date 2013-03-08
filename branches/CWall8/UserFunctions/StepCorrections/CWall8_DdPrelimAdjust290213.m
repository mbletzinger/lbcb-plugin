%------------------------------------------------------------------------%
%       C Wall 8 Dd Preliminary Adjustment Function
%       Andrew Mock
%       Created May 2012
%       Last edit - Jan 2013 by amock
%------------------------------------------------------------------------%
%
%Change log:
%  1/16/13 - UNcommented "always correct mx" and "always correct my"
%
%Config variables called in this file:
%  AlwaysCorrectMx
%  AlwaysCorrectMy
%  setPrelimAxialForce
%  setPrelimMomentX
%  setPrelimMomentY
%
%Arch variables called in this file:
%  PrevDx
%  (PrevDy) assumed to exist...
%  MeasuredMx
%  MeasuredMy


function CWall8_DdPrelimAdjust160113(me,step)
me.log.debug(dbstack,'Running preliminary adjustment fcn');
%------------------------------------------------------------------------%
%  Determine direction of movement
%       NOTE: The direction determination exists in the preliminary adjust
%       function so that the determination occurs only once per step.
%       Therefore, correction steps will use the direction of the overall
%       step.  Finally, the determination looks only at the target from
%       the input file, so changes in Dx and Dy due to ED correction will
%       not throw off the values.
%------------------------------------------------------------------------%

%Look up dx and dy targets from previous step, if exists
if me.existsArch('PrevDx')
    prevdx = me.getArch('PrevDx'); %set in calculate function
    prevdy = me.getArch('PrevDy');
end  

%Read dx and dy target for current step
[disp dDofs force fDofs] = step.lbcbCps{1}.cmdData();
newdx = disp(1);
newdy = disp(2);

%Compare dx and dy values between current step and previous step to
%determine if the direction is being applied.
if abs(newdx) ~= abs(prevdx)
    dispx = 1;
else
    dispx = 0;
end

if abs(newdy) ~= abs(prevdy)
    dispy = 1;
else
    dispy = 0;
end

%Check config variables to see if always correct Mx or My is turned on
if me.existsCfg('AlwaysCorrectMx')
    forcemx = me.getCfg('AlwaysCorrectMx');
    if forcemx == 1
        dispy = 1;
    end
end

if me.existsCfg('AlwaysCorrectMy')
    forcemy = me.getCfg('AlwaysCorrectMy');
    if forcemy == 1
        dispx = 1;
    end
end

%archive values
me.putArch('DirectionX',dispx);
me.putArch('DirectionY',dispy);

%% -----------------------------------------------------------------------%
%------------------------------------------------------------------------%
%
%   Preliminary Axial Force and Moment Prediction
%   Generalized to any combination of prediction DOFs
%
%   By: Andrew W. Mock
%   	awmock2@illinois.edu
%   
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
% User input
%------------------------------------------------------------------------%
%   Set prediciton DOFs
%   Two column matrix:  col 1 = force vector position
%                       col 2 = disp vector position
%   For CW8:    Fx vs Dx
%               Fy vs Dy
PredictionDofs =   [1 1;...     %Fx(1) vs Dx(1)
                    2 2];       %Fy(2) vs Dy(2)
%------------------------------------------------------------------------%
%   Set prediction method               
method = 3;                
% DO NOT MODIFY BELOW THIS LINE           DO NOT MODIFY BELOW THIS LINE
%------------------------------------------------------------------------%
%% Retrieve/set initial vars
if me.existsCfg('HistStepCount')
    maxcount = me.getCfg('HistStepCount');
else
    maxcount = 4;
end

if me.existsArch('CounterFx')
    counter(1) = me.getArch('CounterFx');
    counter(2) = me.getArch('CounterFy');
    counter(3) = me.getArch('CounterFz');
    counter(4) = me.getArch('CounterMx');
    counter(5) = me.getArch('CounterMy');
    counter(6) = me.getArch('CounterMz');
else
    counter(1) = 1;
    counter(2) = 1;
    counter(3) = 1;
    counter(4) = 1;
    counter(5) = 1;
    counter(6) = 1;
end

if me.existsArch('Kmax11')
    Kmax(1,1) = me.getArch('Kmax11');
    Kmax(2,2) = me.getArch('Kmax22');
    Kmax(3,3) = me.getArch('Kmax33');
    Kmax(4,4) = me.getArch('Kmax44');
    Kmax(5,5) = me.getArch('Kmax55');
    Kmax(6,6) = me.getArch('Kmax66');
else
    Kmax(1,1) = 1;
    Kmax(2,2) = 1;
    Kmax(3,3) = 1;
    Kmax(4,4) = 1;
    Kmax(5,5) = 1;
    Kmax(6,6) = 1;
end

if me.existsArch('signprevDx')
    signprev(1) = me.getArch('signprevDx');
    signprev(2) = me.getArch('signprevDy');
    signprev(3) = me.getArch('signprevDz');
    signprev(4) = me.getArch('signprevRx');
    signprev(5) = me.getArch('signprevRy');
    signprev(6) = me.getArch('signprevRz');
else
    signprev(1) = 1;
    signprev(2) = 1;
    signprev(3) = 1;
    signprev(4) = 1;
    signprev(5) = 1;
    signprev(6) = 1;
end

if me.existsArch('PrevDx')
    prevdisp(1) = me.getArch('PrevDx'); %set in calculate function
    prevdisp(2) = me.getArch('PrevDy');
    prevdisp(3) = me.getArch('PrevDz');
    prevdisp(4) = me.getArch('PrevRx');
    prevdisp(5) = me.getArch('PrevRy');
    prevdisp(6) = me.getArch('PrevRz');
end  

%measured forces from calculate function
if me.existsArch('PrevDx')
    F(1) = me.getArch('MeasuredFx'); 
    F(2) = me.getArch('MeasuredFy');
    F(3) = me.getArch('MeasuredFz');
    F(4) = me.getArch('MeasuredMx');
    F(5) = me.getArch('MeasuredMy');
    F(6) = me.getArch('MeasuredMz');
end  
%% Determine 6DOF targets:
% 1. displacement target from input file 
%       (inputfileTarget) 
%
% 2. displacement target delta of step (input file current - input file prev)
%       (inputfileTargetDelta)

inputfileTarget = step.lbcbCps{1}.command.disp;  %1
inputfileTargetprev = prevdisp';
inputfileTargetDelta = inputfileTarget - inputfileTargetprev;  %2

%% predict 6DOF Ftarget based on DOFs set by user
currentsign = zeros(1,6);
histlength = zeros(1,6);
Ftarget = zeros(6,1);
K = zeros(6);
if prevdx == 100 %first step
    Ftarget = F'; %on first step command current forces, NO PREDICTION
else
    for predict = 1:size(PredictionDofs,1)
        dispdof = PredictionDofs(predict,2);
        forcedof = PredictionDofs(predict,1); 
        currentsign(dispdof) = sign(inputfileTargetDelta(dispdof));
        
        if currentsign(dispdof) == 0 %------------------------zero displacement
            counter(dispdof) = 1;
            Ftarget(forcedof) = F(forcedof);          
        elseif counter(dispdof) == 1 %------------------------first step of cycle
            counter(dispdof) = counter(dispdof) + 1;
            Ftarget(forcedof) = F(forcedof);       
                me.log.debug(dbstack,'First step of cycle');          
        elseif currentsign(dispdof) ~= signprev(dispdof) %---------------turnaround
            counter(:) = 1;
            K = Kmax;
            Ftarget = (K*inputfileTargetDelta)+F';
            Kmax = eye(6); %reset max to identity
                me.log.debug(dbstack,'Turnaround step');
        else %---------------------------------------------------prediction
            %form/update disp and force history vectors
            if counter(dispdof) < maxcount
                histlength(dispdof) = counter(dispdof);
                lambda(dispdof) = 1-1/histlength(dispdof);
            else
                histlength(dispdof) = maxcount;
                lambda(dispdof) = 1;
            end
            
            %clear('disphist','forcehist','weights')
            for k=1:histlength(dispdof)
                
                %[disphistory dDOFshist forcehistory fDOFshist] = me.executeHist.get(k).lbcbCps{1}.cmdData  %get the most recently completed step
                
                disphistory = me.executeHist.get(k).lbcbCps{1}.command.disp;
                forcehistory = me.executeHist.get(k).lbcbCps{1}.response.force;
                
                disphist(histlength(dispdof)-k+1,dispdof)=disphistory(dispdof);
                forcehist(histlength(dispdof)-k+1,forcedof)=forcehistory(forcedof);
                weights(k,dispdof) = (1/histlength(dispdof))*k;
            end
            
            %check that disp history is large enough
            deltahist = disphist(histlength(dispdof),dispdof)-disphist(1,dispdof);
            mindeltahist = me.getCfg('MinPredictionDelta');
            if abs(deltahist) < mindeltahist
                counter(dispdof) = counter(dispdof) + 1;
                Ftarget(forcedof) = F(forcedof);
                me.log.debug(dbstack,'Displacement history too small for prediction');
            else
                me.log.debug(dbstack,'Performing prediction');
                
                
                
                %curve fitting solution and stiffness calc
                if method == 3
                    %matlab ordinary least squares fitting
                    %**no curve fitting toolbox required
                    [linefit,S]=polyfit(disphist(:,dispdof),forcehist(:,forcedof),1);
                    K(dispdof,dispdof) = linefit(1)*lambda(dispdof);
                    utarget = inputfileTargetDelta(dispdof)+disphist(histlength(dispdof),dispdof);
                    Ftarget(forcedof) = (polyval(linefit,utarget)-F(forcedof))*lambda(dispdof)+F(forcedof);
                end
%                 if method == 4
%                     straight line least squares fitting using toolbox
%                     [linefit, Goflinefit, Outputlinefit] = fit(disphist(:,dof),forcehist(:,dof),'poly1');
%                     K(dof,dof) = differentiate(linefit,Cmnd(i,dof+4));
%                     Ftarget(dof) = ((linefit(utarget2(dof))-F(dof))+F(dof))*lambda(dispdof);
%                 end
%                 if method == 5
%                     weighted straight line least squares fitting using toolbox
%                     [linefit, Goflinefit, Outputlinefit] = fit(disphist(:,dof),forcehist(:,dof),'poly1','Weights',weights(:,dof));
%                     K(dof,dof) = differentiate(linefit,Cmnd(i,dof+4));
%                     Ftarget(dof) = ((linefit(utarget2(dof))-F(dof))+F(dof))*lambda(dispdof);
%                 end
                counter(dispdof) = counter(dispdof) + 1;
                % update max 6DOF stiffness for this cycle
                for j=1:6
                    if K(j,j) > Kmax(j,j)
                        Kmax(j,j) = K(j,j);
                    end
                end
            end
        end
    end
end

% archive 6DOF vars
me.putArch('PrevDx',inputfileTarget(1));
me.putArch('PrevDy',inputfileTarget(2));
me.putArch('PrevDz',inputfileTarget(3));
me.putArch('PrevRx',inputfileTarget(4));
me.putArch('PrevRy',inputfileTarget(5));
me.putArch('PrevRz',inputfileTarget(6));

me.putArch('signprevDx',currentsign(1));
me.putArch('signprevDy',currentsign(2));
me.putArch('signprevDz',currentsign(3));
me.putArch('signprevRx',currentsign(4));
me.putArch('signprevRy',currentsign(5));
me.putArch('signprevRz',currentsign(6));

me.putArch('CounterFx',counter(1))
me.putArch('CounterFy',counter(2))
me.putArch('CounterFz',counter(3))
me.putArch('CounterMx',counter(4))
me.putArch('CounterMy',counter(5))
me.putArch('CounterMz',counter(6))

me.putArch('Kmax11',Kmax(1,1))
me.putArch('Kmax22',Kmax(2,2))
me.putArch('Kmax33',Kmax(3,3))
me.putArch('Kmax44',Kmax(4,4))
me.putArch('Kmax55',Kmax(5,5))
me.putArch('Kmax66',Kmax(6,6))

%------------------------------------------------------------------------%
% END OF MOMENT PREDICTION ALGORITHM
%
% DO NOT MODIFY ABOVE THIS LINE           DO NOT MODIFY ABOVE THIS LINE
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%

me.putArch('K11',K(1,1))
me.putArch('K22',K(2,2))

me.putArch('PredictedFx',Ftarget(1))
me.putArch('PredictedFy',Ftarget(2))
%% command force targets to "step.lbcbCps{1}.command.setForceDof"

%check if preliminary axial set is turned on
sfz = true;
if me.existsCfg('setPrelimAxialForce')
    spfz = me.getCfg('setPrelimAxialForce');
    sfz = spfz == 1;
end

%check if preliminary moment set is turned on for each DOF
smx = true;
if me.existsCfg('setPrelimMomentX')
    spfz = me.getCfg('setPrelimMomentX');
    smx = spfz == 1;
end

smy = true;
if me.existsCfg('setPrelimMomentY')
    spfz = me.getCfg('setPrelimMomentY');
    smy = spfz == 1;
end

spredict = true;
if me.existsCfg('Prediction')
    sspred = me.getCfg('Prediction');
    spredict = sspred == 1;
end

%% predict target using calculate function
if spredict == 1
    SAmsr = me.getCfg('MyFxMomentShearRatio'); %Strong Axis Moment to Shear Ratio
    %WAmsr = me.getCfg('MxFyMomentShearRatio'); %Weak Axis Moment to Shear Ratio
    fx = Ftarget(1);
    fy = Ftarget(2);
    fz = step.lbcbCps{1}.response.force(3);
    mmx = step.lbcbCps{1}.response.force(4);
    mmy = step.lbcbCps{1}.response.force(5);
    mmz = step.lbcbCps{1}.response.force(6);
  
    
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
    
    if me.existsCfg('MbaseCoupleRatio')
        Mbase_couple_ratio = me.getCfg('MbaseCoupleRatio');
    else
        Mbase_couple_ratio = 0.80;
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
    if me.existsCfg('AlphaTen')
        alphaten = me.getCfg('AlphaTen');
    else
        alphaten = 0.71;
    end
    if me.existsCfg('HeightTen')
        hten = me.getCfg('HeightTen');
    else
        hten = 480;
    end
    
    M_base = alphaten*hten*V_base;      %Base moment of coupled core-wall system
    
    if me.existsCfg('Alpha3rd')
        alphathird = me.getCfg('Alpha3rd');
    else
        alphathird = 0.577;
    end
    M_third = alphathird*M_base;
    
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
    if me.existsCfg('CoupleLength')
        Lcouple = me.getCfg('CoupleLength');
    else
        Lcouple = 94.2;
    end
    fc = me.getCfg('CompressiveStrengthfc');
    Ag = me.getCfg('GrossArea');
    BeamWeight = me.getCfg('BeamWeight');
    if dy < 0
        P_C = Mbase_couple_ratio*M_third/Lcouple + 0.05*fc*Ag - BeamWeight;	%Wall is in tension
    else
        P_C = Mbase_couple_ratio*M_third/Lcouple + 0.05*fc*Ag - BeamWeight;     %Wall is in compression
    end
    
    %set force and moment targets
    if dispx == 1 %x movement
        if smy
            my = Ftarget(1)*SAmsr;
            step.lbcbCps{1}.command.setForceDof(5,my);
        else
            me.log.debug(dbstack,'Not setting My Moment in initial command');
        end
        if sfz
            fz = me.getCfg('AxialForce');
            step.lbcbCps{1}.command.setForceDof(3,fz);
        else
            me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
        end
    end

    if dispy == 1 %y movement
        if smx
            mx = M_top_C;
            step.lbcbCps{1}.command.setForceDof(4,mx);
        else
            me.log.debug(dbstack,'Not setting Mx Moment in initial command');
        end
        %step.lbcbCps{1}.command.setForceDof(4,mx);
        if sfz
            fz = P_C;
            step.lbcbCps{1}.command.setForceDof(3,fz);
        else
            me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
        end
    end

else
    %set force and moment targets
        
    if dispx == 1 %x movement
        if smy
            my = me.getArch('MeasuredMy');
            step.lbcbCps{1}.command.setForceDof(5,my);
        else
            me.log.debug(dbstack,'Not setting My Moment in initial command');
        end
        %step.lbcbCps{1}.command.setForceDof(5,my);
        if sfz
            fz = me.getCfg('AxialForce');
            step.lbcbCps{1}.command.setForceDof(3,fz);
        else
            me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
        end
    end
    
    if dispy == 1 %y movement
        if smx
            mx = me.getArch('MeasuredMx');
            step.lbcbCps{1}.command.setForceDof(4,mx);
        else
            me.log.debug(dbstack,'Not setting Mx Moment in initial command');
        end
        %step.lbcbCps{1}.command.setForceDof(4,mx);
        if sfz
            fz = me.getArch('ProposedFz');
            step.lbcbCps{1}.command.setForceDof(3,fz);
        else
            me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
        end
    end

end
me.log.debug(dbstack,sprintf('Prelim Adjusted step: %s',step.toString()));

end
