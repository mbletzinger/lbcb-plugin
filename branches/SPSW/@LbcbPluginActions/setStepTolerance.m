function setStepTolerance(me,dof,lbcb,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d to [%s]',dof,lbcb,str));
tol = me.hfact.gui.tolerances{lbcb};
tol.setCell(dof,str);
end

