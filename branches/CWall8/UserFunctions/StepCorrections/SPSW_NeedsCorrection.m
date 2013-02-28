function Needs_Correction = SPSW_NeedsCorrection( me )

%...Get tolerances
    My_tol = me.getCfg('My_tol');
    Fz_tol = me.getCfg('Fz_tol');

%...Get errors
    My1_error = me.getArch('My1_error');
    My2_error = me.getArch('My2_error');
    Fz1_error = me.getArch('Fz1_error');
    Fz2_error = me.getArch('Fz2_error');
    
%...Compare errors to tolerances
    if My1_error > My_tol ||...
            My2_error > My_tol ||...
            Fz1_error > Fz_tol ||...
            Fz2_error > Fz_tol
        Needs_Correction = true;
    else
        Needs_Correction = false;
    end
    
end

