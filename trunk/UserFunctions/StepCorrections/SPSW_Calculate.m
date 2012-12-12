function SPSW_Calculate( me, step )
    
%...Get current shear
    Fx1 = step.lbcbCps{1}.response.force(1);
    Fx2 = step.lbcbCps{2}.response.force(1);
    Fx_total = Fx1 + Fx2;
    
    Fz1 = step.lbcbCps{1}.response.force(3);
    Fz2 = step.lbcbCps{2}.response.force(3);
    My1 = step.lbcbCps{1}.response.force(5);
    My2 = step.lbcbCps{2}.response.force(5);
    
%...Calculate targets
    [My_target, Fz1_target, Fz2_target] = SPSW_CalculateTargets(me, Fx_total);
    
%...Calculate errors
    My1_error = abs(My1-My_target);
    My2_error = abs(My2-My_target);
    Fz1_error = abs(Fz1-Fz1_target);
    Fz2_error = abs(Fz2-Fz2_target);

%...Archive variables
    me.putArch('Fx_total',Fx_total);
    me.putArch('My_target',My_target);
    me.putArch('Fz1_target',Fz1_target);
    me.putArch('Fz2_target',Fz2_target);
    
    me.putArch('My1_error',My1_error);
    me.putArch('My2_error',My2_error);
    me.putArch('Fz1_error',Fz1_error);
    me.putArch('Fz2_error',Fz2_error);

end

