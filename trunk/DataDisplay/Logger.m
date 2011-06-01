classdef Logger < handle
    properties
        levelTypes = StateEnum({...
            'DEBUG',...
            'INFO',...
            'WARNING',...
            'ERROR'...
            });
        class
    end
    methods
        function me = Logger(class)
            me.class = class;
        end
        function debug(me,stack,msg)
           me.process('DEBUG',stack,msg);
        end
        function info(me,stack,msg)
           me.process('INFO',stack,msg);
        end
        function warning(me,stack,msg)
           me.process('WARNING',stack,msg);
        end
        function error(me,stack,msg)
           me.process('ERROR',stack,msg);
        end
    end
    methods (Access = private)
        function process(me,level,stack,msg)
            me.levelTypes.setState(level)
            cl = Logger.getCmdLevel();
            if me.levelTypes.greaterThanOrEqualTo(cl)
                str = sprintf('%s - %s: %s',level,me.sstring(stack),msg);
                disp(str);
            end
            ml = Logger.getMsgLevel();
            hnd = Logger.getMsgHandle();
            if me.levelTypes.greaterThanOrEqualTo(ml) && isempty(hnd) == 0
                if me.levelTypes.isState('INFO')
                    str = msg;
                else
                    str = sprintf('%s: %s',level,msg);
                end
                msgs = get(hnd,'String');
                if ischar(msgs)
                    nmsgs = {str};
                else
                    nmsgs = [ msgs; {str}];
                end
                set(hnd,'String',nmsgs);
                set(hnd,'Value',length(nmsgs));
            end
            if Logger.getRecord()
                archive = getArchive();
                str = sprintf('%s - %s: %s',level,me.sstring(stack),msg);
                archive.writeText(str);
            end
        end
        function str = sstring(me, stack) 
            if length(stack) > 1
            str = sprintf('%s.%s>%s,%d',me.class,stack(1).file,stack(1).name,stack(1).line);
            else
                str = 'MAIN';
            end
        end
    end
    methods (Static)
        function setCmdLevel(level)
            global cmdLevel;
            cmdLevel = level;
        end
        function level = getCmdLevel()
            global cmdLevel;
            level = cmdLevel;
        end
        function setMsgLevel(level)
            global msgLevel;
            msgLevel = level;
        end
        function level = getMsgLevel()
            global msgLevel;
            level = msgLevel;
        end
        function setMsgHandle(handle)
            global msgHandle;
            msgHandle = handle;
        end
        function handle = getMsgHandle()
            global msgHandle;
            handle = msgHandle;
        end
        function setRecord(rec)
            global record;
            record = rec;
        end
        function rec = getRecord()
            global record;
            rec = record;
        end
        function arch = getArchive()
            global archive
            if isempty(archive)
                archive = TextArchive('Messages');
            end
            arch = archive;
        end
    end
end