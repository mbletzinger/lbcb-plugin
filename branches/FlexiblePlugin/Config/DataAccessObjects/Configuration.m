% =====================================================================================================================
% Class that stores and loads properties in a Java style properties file
%
% Members:
%   props - Java properties object.
%   filename - default filename.
%   error - Current error message.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef Configuration < handle
    properties
        props = org.nees.uiuc.simcor.properties.Props;
        filename = '';
        error = '';
        arch
        dat
    end
    methods
        function me = Configuration()
            root = pwd;
            me.filename = fullfile(root,'lbcb_plugin.properties');
        end
        % load the default configuration
        function done = load(me)
            done = me.loadFile(me.filename);
        end
        % save the configuration as the default
        function done = save(me)
            done = me.saveFile(me.filename);
        end
        % import a configuration
        function import(me)
            done = 0;
            while done == false
               [fileName,pathName,filterIndex] = uigetfile('*.properties','Import Configuration'); %#ok<NASGU>
                if fileName == 0
                    return
                end
                done = me.loadFile(fullfile(pathName,fileName));
                if done == 0
                    errordlg(me.error);
                end
            end
        end
        % export a configuration
        function export(me)
            done = 0;
            while done == false
                [fileName,pathName,filterIndex] = uiputfile('*.properties','Export Configuration'); %#ok<NASGU>
                if fileName == 0
                    return
                end
                done = me.saveFile(fullfile(pathName,fileName));
                if done == 0
                    errordlg(me.error);
                end
            end
        end
        function done = loadFile(me,name)
            result = me.props.load(name);
            if isempty(result)
                done = 1;
                me.error = '';
                return;
            end
            me.error = result;
            done = 0;
        end
        function done = saveFile(me,name)
            result = me.props.save(name);
            if isempty(result)
                done = 1;
                me.error = '';
                return;
            end
            me.error = result;
            done = 0;
        end
        function logValueChange(me,key,value)
            step = me.dat.curStepData;
            me.arch.storeNote(sprintf('%s was changed to %s',key,value),step);
        end
        function logListChange(me,key,list)
            step = me.dat.curStepData;
            me.arch.storeNote(sprintf('%s was changed to %s',key,char(me.props.propertyList2String(list))),step);
        end
    end
end