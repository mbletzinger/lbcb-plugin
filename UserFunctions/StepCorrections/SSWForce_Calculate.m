function SSWForce_Calculate( me, step )
me.log.debug(dbstack,'Running calculate forces fcn');
% Store the infighting forces.
dlabels = ['Fx', 'Fy', 'Mx', 'My'];
dofs = [1,2,4,5];
for lbcb = 1:2
    for d = 1:4
        force = step.lbcbCps{lbcb}.response.force(dofs(d));
        label = sprintf('MeasL%d$s',lbcb,dlabels{d});
        me.putArch(label,force);
    end
end


Fz1 = step.lbcbCps{1}.response.force(3);
Fz2 = step.lbcbCps{2}.response.force(3);
Fz_total = Fz1 + Fz2;
%...Archive variables
me.putArch('FzTotal',Fz_total);

end

