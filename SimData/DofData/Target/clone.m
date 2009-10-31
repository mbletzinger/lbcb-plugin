function clone = clone(me)
clone = Target;
clone.dispDofs = me.dispDofs;
clone.forceDofs = me.forceDofs;
clone.disp = me.disp;
clone.force = me.force;
clone.node = me.node;
clone.cps = me.cps;
end
