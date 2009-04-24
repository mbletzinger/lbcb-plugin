classdef ElasticDeformationCalculations < handle
    properties
        extTrans = {};
        extTransParams = {};

        lbcb1EdState = {};
        lbcb2EdState = {};
        
        stepExecuteState = stateEnum({...
            'Send Target LBCB1',...
            'Send Target LBCB2',...
            'Send Execute',...
            'Get Control Point LBCB1',...
            'Get Control Point LBCB2',...
            'Get Control Point External Transducers',...
            });
   end
    methods
        function me = elasticDeformationCalculations()
            [me.extTrans,lbcbGeos,me.extTransParams] = CreateExternalTransducerObjects();
            me.lbcb1EdState = externalTransducers2LbcbLocation(lbcbGeos{1});
            me.lbcb1EdState.reset();
            me.lbcb2EdState = externalTransducers2LbcbLocation(lbcbGeos{2});
            me.lbcb2EdState.reset();
        end
        function readings = calculate(readings)
            me.extTransControlPoint.update(readings{});
           lengths = me.lbcb1EdState.geometry.sensorValuesSubset(me.extTrans.currentLengths);
           readings{1}.ed.disp = ExtTrans2Cartesian(me.lbcb1EdState,me.extTransParams,lengths);
           lengths = me.lbcb2EdState.geometry.sensorValuesSubset(me.extTrans.currentLengths);
           readings{2}.ed.disp = ExtTrans2Cartesian(me.lbcb2EdState,me.extTransParams,lengths);
        end
    end
end