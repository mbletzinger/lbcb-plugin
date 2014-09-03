function SSWForce_Calculate( me, step )
    
    
    Fz1 = step.lbcbCps{1}.response.force(3);
    Fz2 = step.lbcbCps{2}.response.force(3);
    Fz_total = Fz1 + Fz2;
    %...Archive variables
    me.putArch('FzTotal',Fz_total);
    
end

