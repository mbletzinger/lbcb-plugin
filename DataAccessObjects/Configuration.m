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
                name = uigetfile('','Import Configuration');
                if name == 0
                    return
                end
                done = me.loadFile(name);
                if done == 0
                    errordlg(me.error);
                end
            end
        end
        % export a configuration
        function export(me)
            done = 0;
            while done == false
                name = uigetfile('','Export Configuration');
                if name == 0
                    return
                end
                done = me.saveFile(name);
                if done == 0
                    errordlg(me.error);
                end
            end
        end
    end
    methods (Access='private')
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
    end
end