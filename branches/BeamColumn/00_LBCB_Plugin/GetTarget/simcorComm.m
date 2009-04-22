classdef simcorComm < handle
    properties
        factory = {};
        lsm = {};
        targets = cell(3,1);
        readings = cell(3,1);
        commandPending = 1;
        m2d = msg2DofData();
        response = {};
        command = {};
    end
    methods
        function me = simcorComm(factory,linkState)
            me.factory = factory;
            me.lsm = linkState;
        end
        
        function getCommand(me)
            me.commandPending = 1;
        end
        
        function sendResponse(me,responses)
            me.commandPending = 1;
            me.response = responses;
        end

        function done = execute(me)
            done = 0;
            switch me.lsm.state.getState()
                case 'READY'
                    if me.commandPending
                        me.lsm.execute('RECEIVE');
                    else
                        cnt = '';
                        for t = 1: length(me.response)
                            if t > 1
                                cnt = sprintf('%s\t%s\t%s',cnt,me.response.node,me.response.createMsg());
                            else
                                cnt = sprintf('%s\t%s',cnt,me.response.createMsg());
                            end
                        end
                        rsp = me.factory.createResponse(cnt,'',me.lsm.link.command);
                        me.lsm.execute('SEND',rsp);
                    end
                case 'PENDING'
                    me.lsm.check();
                case 'DONE'
                    if me.commandPending
                        cmd = me.lsm.link.command.getCommand();
                        if strcmp(cmd,'propose')
                            cnt = me.lsm.link.command.getContent();
                            nd = me.lsm.link.command.getNode();
                            me.command = m2d.parse(cnt,nd);
                        end
                        me.commandPending = 0;
                    else
                        me.commandPending = 0;
                        done = 1;
                    end
                    me.lsm.reset();
                case 'ERROR'
            end
        end
    end
end