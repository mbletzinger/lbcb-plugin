function [My_target, Fz1_target, Fz2_target] = SPSW_CalculateTargets( me, Fx_total)

%...Retreive geometric parameters
    L = me.getCfg('BayWidth');
    e = me.getCfg('CoupledLength');
    GL = me.getCfg('GravityLoad');      %Should be positive (down) input

    DC = me.getCfg('DC');
    h_bar = me.getCfg('EffectiveHeight_Top');
    top_proportion = me.getCfg('Top_Shear_Proportion');
    
%...Get moment above the simulation cut
    V_top = top_proportion*Fx_total;
    M_top = -V_top*h_bar;       %Right hand rule

%...Calculate target forces at top of each pier
    My_target = M_top*(1-DC)/2;  %Positive Fx, Negative My
    Fz1_target = M_top*DC/(e+L) + GL/2; %Positve Fx, left pier in tension, negative Fz
    Fz2_target = -M_top*DC/(e+L) + GL/2;  
    
end

