classdef genOmConfig < handle
    
    %UNTITLED Summary of this class goes here
    %Detailed explanation goes here
    
    properties
        %Should anything be included here for this class?
    end
    
    methods
        
        function generate(cfg)
            
            ocfg = OmConfigDao(cfg);
            
            ocfg.sensorNames = {'Ext.Long.LBCB2' 'Ext.Tranv.TopLBCB2' 'Ext.Tranv.Bot.LBCB2',...
    'Ext.Long.LBCB1', 'Ext.Tranv.LeftLBCB1' 'Ext.Tranv.RightLBCB1'}';
            
            ocfg.apply2Lbcb = {'LBCB2' 'LBCB2' 'LBCB2' 'LBCB1' 'LBCB1' 'LBCB1'}';
            
            ocfg.numLbcbs = 2;
            ocfg.sensitivities = ones(6,1) * 0.99994;
            
            perts = [.333 .333 0 .000222 0 0 .444 .444 0 .00011 0 0 ];
            tgts = {Target Target };
            
            for t = 1:6
                tgts{1}.setDispDof(t,perts(t));
                tgts{2}.setDispDof(t,perts(t+6));
            end
            
            ocfg.perturbationsL1 = tgts{1};
            ocfg.perturbationsL2 = tgts{2};
            
            %What about the other properties of ocfg? Shouldn't the values
            %of those other properties be generated as well?
            
        end
        
    end
    
end

