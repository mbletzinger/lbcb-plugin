         % Convert a message into a command.
        function parse(me,msg,node)
            targets = me.m2d.parse(msg,node);
            me.disp = targets{1}.disp;
            me.dispDofs = targets{1}.dispDofs;
            me.force = targets{1}.force;
            me.forceDofs = targets{1}.forceDofs;
            me.node = node;
        end
