function SPSW_AdjustTarget( me, step )
    
%...Retreive calculated targets
    My_target = me.getArch('My_target');
    Fz1_target = me.getArch('Fz1_target');
    Fz2_target = me.getArch('Fz2_target');
    
%...Apply targets
    step.lbcbCps{1}.command.setForceDof(5,My_target);
    step.lbcbCps{2}.command.setForceDof(5,My_target);

    step.lbcbCps{1}.command.setForceDof(3,Fz1_target);
    step.lbcbCps{2}.command.setForceDof(3,Fz2_target);
    
end

