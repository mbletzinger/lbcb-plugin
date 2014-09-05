classdef DisplayFactory < handle
    properties
        mainDisp
        dispIdxs
        disps
        idx
        checkHndls
        dat
        cdp
        stats
        loadP
    end
    methods
        function me = DisplayFactory(handle)
            me.mainDisp = handle;
            me.idx = 1;
            me.dispIdxs = org.nees.uiuc.simcor.matlab.HashTable();
            me.disps = {};
            DisplayFactory.setMe(me);
        end
        function addDisplay(me,name,ref,chkhndl)
            me.dispIdxs.put(name,me.idx);
            me.disps{me.idx} = ref;
            me.checkHndls{me.idx} = chkhndl;
            me.idx = me.idx + 1;
        end
        function initialize(me,handle)
            me.mainDisp = handle;
            %                         ref = ArchStepPlot('EdDz','EdDz',me.dat);
            %                         ref.cdp = me.cdp;
            %                         me.addDisplay('EdDz',ref,me.mainDisp.EdDz);
            %             ref = ArchPlot('TotalFxVsLbcb2Dx',0,1,'Fx total');
            %             ref.cdp = me.cdp;
            %             me.addDisplay('TotalFxVsLbcb2Dx',ref,me.mainDisp.TotalFxVsLbcb2Dx);
            %             ref = ArchPlot('TotalMyVsLbcb1Dx',1,1,'My total');
            %             ref.cdp = me.cdp;
            %             me.addDisplay('TotalMyVsLbcb1Dx',ref,me.mainDisp.TotalMyVsLbcb1Dx);
            %             ref = ArchPlot('TotalMyVsLbcb2Dx',0,1,'My total');
            %             ref.cdp = me.cdp;
            %             me.addDisplay('TotalMyVsLbcb2Dx',ref,me.mainDisp.TotalMyVsLbcb2Dx);
            %             ref = MultiDofStepPlot('CumulativeMoment',{'PDelta','ShearL','MomentY'},'Y Moments',1,1);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('CumulativeMoment',ref,me.mainDisp.CumulativeMoment);
            %             ref = MultiDofStepPlot('TopBottomMoment',{'MyBottom','MCrack','MomentY'},'Y Moments',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('TopBottomMoment',ref,me.mainDisp.TopBottomMoment);
            %                         ref = ArchPlot('DxVsMyBottom',1,1,'MyBottom');
            %                         ref.cdp = me.cdp;
            %                         me.addDisplay('DxVsMyBottom',ref,me.mainDisp.DxVsMyBottom);
            %             ref = ArchPlot('MyTopVsMyBottom',1,11,'MyBottom');
            %             ref.cdp = me.cdp;
            %             me.addDisplay('MyTopVsMyBottom',ref,me.mainDisp.MyTopVsMyBottom);
            %             ref = MultiDofStepPlot('OutOfPlaneTranslations',{'Dy','Dz'},'inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('OutOfPlaneTranslations',ref,me.mainDisp.OutOfPlaneTranslations);
            %             ref = MultiDofStepPlot('OutOfPlaneRotations',{'Rx','Ry','Rz'},'rad',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('OutOfPlaneRotations',ref,me.mainDisp.OutOfPlaneRotations);
            %
            ref = MultiDofStepPlot('SSW_Dz',{'EdDz','MeasEast','MeasNorth', 'MeasWest', 'CorrectDz'},'inches',1,0);
            ref.cdp = me.cdp;
            me.addDisplay('SSW_Dz',ref,me.mainDisp.SSW_Dz);
            
            ref = MultiDofStepPlot('SSW_Rotations',{'EdRy','EdRx'},'radians',1,0);
            ref.cdp = me.cdp;
            me.addDisplay('SSW_Rotations',ref,me.mainDisp.SSW_Rotations);

%             ref = ArchPlot('SSW Deformation',0,3,'TotalFz');
%             ref.cdp = me.cdp;
%             me.addDisplay('TotalFxVsLbcb2Dx',ref,me.mainDisp.TotalFxVsLbcb2Dx);
            
            ref = MultiDofStepPlot('L1 Forces',{'Fx','Fy','Fz', 'TotalFz'},'kips',1,0);
            ref.cdp = me.cdp;
            me.addDisplay('L1Forces',ref,me.mainDisp.L1Forces);
            
            
            
            ref = MultiDofStepPlot('L1 Moments',{'Mx','My','Mz'},'kip*inches',1,0);
            ref.cdp = me.cdp;
            me.addDisplay('L1Moments',ref,me.mainDisp.L1Moments);
            
            ref = MultiDofStepPlot('L1 Displacements',{'Dx','Dy','Dz'},'inches',1,0);
            ref.cdp = me.cdp;
            me.addDisplay('L1Displacements',ref,me.mainDisp.L1Displacements);
            
            ref = MultiDofStepPlot('L1 Rotations',{'Rx','Ry','Rz'},'radians',1,0);
            ref.cdp = me.cdp;
            me.addDisplay('L1Rotations',ref,me.mainDisp.L1Rotations);
            
            ref = MultiDofStepPlot('L2 Forces',{'Fx','Fy','Fz', 'TotalFz'},'kips',0,0);
            ref.cdp = me.cdp;
            me.addDisplay('L2Forces',ref,me.mainDisp.L2Forces);
            
            ref = MultiDofStepPlot('L2 Moments',{'Mx','My','Mz'},'kip*inches',0,0);
            ref.cdp = me.cdp;
            me.addDisplay('L2Moments',ref,me.mainDisp.L2Moments);
            
            ref = MultiDofStepPlot('L2 Displacements',{'Dx','Dy','Dz'},'inches',0,0);
            ref.cdp = me.cdp;
            me.addDisplay('L2Displacements',ref,me.mainDisp.L2Displacements);
            
            ref = MultiDofStepPlot('L2 Rotations',{'Rx','Ry','Rz'},'radians',0,0);
            ref.cdp = me.cdp;
            me.addDisplay('L2Rotations',ref,me.mainDisp.L2Rotations);
            
            %             ref = MultiDofStepPlot('MxCorrections',{'ProposedMx','MeasuredMx'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('MxCorrections',ref,me.mainDisp.MxCorrections);
            %
            %             ref = MultiDofStepPlot('MyCorrections',{'ProposedMy','MeasuredMy'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('MyCorrections',ref,me.mainDisp.MyCorrections);
            % %
            %             ref = MultiDofStepPlot('Eccentricities',{'MeasuredMoment2ShearX', 'MeasuredMoment2ShearY'},'inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('Eccentricities',ref,me.mainDisp.Eccentricities);
            %
            %             ref = MultiDofStepPlot('CoupledWallAxialLoad',{'MeasuredFz', 'ProposedFz', 'C_AxialLoad'},'kip',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('CoupledWallAxialLoad',ref,me.mainDisp.CoupledWallAxialLoad);
            % % %
            %             ref = MultiDofStepPlot('CoupledWallMoments',{'System_BaseMoment', 'System_ThirdStoryMoment', 'C_ThirdStoryMoment'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('CoupledWallMoments',ref,me.mainDisp.CoupledWallMoments);
            % % %
            %             ref = MultiDofStepPlot('CoupledWallShears',{'System_BaseShear', 'C_BaseShear'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('CoupledWallShears',ref,me.mainDisp.CoupledWallShears);
            % % %
            %             ref = MultiDofStepPlot('PredictedFx',{'PredictedFx','MeasuredFx'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('PredictedFx',ref,me.mainDisp.PredictedFx);
            % % %
            %             ref = MultiDofStepPlot('PredictedFy',{'PredictedFy','MeasuredFy'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('PredictedFy',ref,me.mainDisp.PredictedFy);
            % % %
            %             ref = MultiDofStepPlot('MeasuredStiffness',{'K11','Kmax11','K22','Kmax22'},'kip*inches',1,0);
            %             ref.cdp = me.cdp;
            %             me.addDisplay('MeasuredStiffness',ref,me.mainDisp.MeasuredStiffness);
            %
            ref = VsPlot('RyVsLbcb1Dx',1,1,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyVsLbcb1Dx',ref,me.mainDisp.RyVsLbcb1Dx);
            ref = VsPlot('RyVsLbcb2Dx',0,1,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyVsLbcb2Dx',ref,me.mainDisp.RyVsLbcb2Dx);
            ref = VsPlot('FxVsLbcb1Dx',1,1,7);
            ref.cdp = me.cdp;
            me.addDisplay('FxVsLbcb1Dx',ref,me.mainDisp.FxVsLbcb1Dx);
            ref = VsPlot('FxVsLbcb2Dx',0,1,7);
            ref.cdp = me.cdp;
            me.addDisplay('FxVsLbcb2Dx',ref,me.mainDisp.FxVsLbcb2Dx);
            ref = VsPlot('MyVsLbcb1Dx',1,1,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyVsLbcb1Dx',ref,me.mainDisp.MyVsLbcb1Dx);
            ref = VsPlot('MyVsLbcb2Dx',0,1,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyVsLbcb2Dx',ref,me.mainDisp.MyVsLbcb2Dx);
            
            ref = VsPlot('FyVsLbcb1Dy',1,2,8);
            ref.cdp = me.cdp;
            me.addDisplay('FyVsLbcb1Dy',ref,me.mainDisp.FyVsLbcb1Dy);
            ref = VsPlot('MxVsLbcb1Dy',1,2,10);
            
            ref = VsPlot('FzVsLbcb1Dz',1,3,9);
            ref.cdp = me.cdp;
            me.addDisplay('FzVsLbcb1Dz',ref,me.mainDisp.FzVsLbcb2Dz);
            ref = VsPlot('FzVsLbcb2Dz',0,3,9);
            ref.cdp = me.cdp;
            me.addDisplay('FzVsLbcb2Dz',ref,me.mainDisp.FzVsLbcb2Dz);
            
            
            ref.cdp = me.cdp;
            me.addDisplay('MxVsLbcb1Dy',ref,me.mainDisp.MxVsLbcb1Dy);
            ref = VsPlot('RxVsLbcb1Dy',1,2,4);
            ref.cdp = me.cdp;
            me.addDisplay('RxVsLbcb1Dy',ref,me.mainDisp.RxVsLbcb1Dy);
            
            ref = OneDofStepPlot('DxStepL1',1,me.dat,1);
            ref.cdp = me.cdp;
            me.addDisplay('DxStepL1',ref,me.mainDisp.DxStepL1);
            ref = OneDofStepPlot('DxStepL2',0,me.dat,1);
            ref.cdp = me.cdp;
            me.addDisplay('DxStepL2',ref,me.mainDisp.DxStepL2);
            ref = OneDofStepPlot('DyStepL1',1,me.dat,2);
            ref.cdp = me.cdp;
            me.addDisplay('DyStepL1',ref,me.mainDisp.DyStepL1);
            ref = OneDofStepPlot('DyStepL2',0,me.dat,2);
            ref.cdp = me.cdp;
            me.addDisplay('DyStepL2',ref,me.mainDisp.DyStepL2);
            ref = OneDofStepPlot('DzStepL1',1,me.dat,3);
            ref.cdp = me.cdp;
            me.addDisplay('DzStepL1',ref,me.mainDisp.DzStepL1);
            ref = OneDofStepPlot('DzStepL2',0,me.dat,3);
            ref.cdp = me.cdp;
            me.addDisplay('DzStepL2',ref,me.mainDisp.DzStepL2);
            ref = OneDofStepPlot('RxStepL1',1,me.dat,4);
            ref.cdp = me.cdp;
            me.addDisplay('RxStepL1',ref,me.mainDisp.RxStepL1);
            ref = OneDofStepPlot('RxStepL2',0,me.dat,4);
            ref.cdp = me.cdp;
            me.addDisplay('RxStepL2',ref,me.mainDisp.RyStepL2);
            ref = OneDofStepPlot('RyStepL1',1,me.dat,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyStepL1',ref,me.mainDisp.RyStepL1);
            ref = OneDofStepPlot('RyStepL2',0,me.dat,5);
            ref.cdp = me.cdp;
            me.addDisplay('RyStepL2',ref,me.mainDisp.RyStepL2);
            ref = OneDofStepPlot('RzStepL1',1,me.dat,6);
            ref.cdp = me.cdp;
            me.addDisplay('RzStepL1',ref,me.mainDisp.RzStepL1);
            ref = OneDofStepPlot('RzStepL2',0,me.dat,6);
            ref.cdp = me.cdp;
            me.addDisplay('RzStepL2',ref,me.mainDisp.RzStepL2);
            
            ref = OneDofStepPlot('FxStepL1',1,me.dat,7);
            ref.cdp = me.cdp;
            me.addDisplay('FxStepL1',ref,me.mainDisp.FxStepL1);
            ref = OneDofStepPlot('FxStepL2',0,me.dat,7);
            ref.cdp = me.cdp;
            me.addDisplay('FxStepL2',ref,me.mainDisp.FxStepL2);
            
            ref = OneDofStepPlot('FyStepL1',1,me.dat,8);
            ref.cdp = me.cdp;
            me.addDisplay('FyStepL1',ref,me.mainDisp.FxStepL1);
            ref = OneDofStepPlot('FyStepL2',0,me.dat,8);
            ref.cdp = me.cdp;
            me.addDisplay('FyStepL2',ref,me.mainDisp.FxStepL2);
            
            ref = OneDofStepPlot('FzStepL1',1,me.dat,9);
            ref.cdp = me.cdp;
            me.addDisplay('FzStepL1',ref,me.mainDisp.FzStepL1);
            ref = OneDofStepPlot('FzStepL2',0,me.dat,9);
            ref.cdp = me.cdp;
            me.addDisplay('FzStepL2',ref,me.mainDisp.FzStepL2);
            
            ref = OneDofStepPlot('MxStepL1',1,me.dat,10);
            ref.cdp = me.cdp;
            me.addDisplay('MxStepL1',ref,me.mainDisp.MxStepL1);
            ref = OneDofStepPlot('MxStepL2',0,me.dat,10);
            ref.cdp = me.cdp;
            me.addDisplay('MxStepL2',ref,me.mainDisp.MxStepL2);
            
            ref = OneDofStepPlot('MyStepL1',1,me.dat,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyStepL1',ref,me.mainDisp.MyStepL1);
            ref = OneDofStepPlot('MyStepL2',0,me.dat,11);
            ref.cdp = me.cdp;
            me.addDisplay('MyStepL2',ref,me.mainDisp.MyStepL2);
            
            ref = OneDofStepPlot('MzStepL1',1,me.dat,12);
            ref.cdp = me.cdp;
            me.addDisplay('MzStepL1',ref,me.mainDisp.MzStepL1);
            ref = OneDofStepPlot('MzStepL2',0,me.dat,12);
            ref.cdp = me.cdp;
            me.addDisplay('MzStepL2',ref,me.mainDisp.MzStepL2);
            
            me.loadP = cell(4,1);
            p = 1;
            ref = LoadProtocolPlot(true,me.dat,3);
            me.loadP{p} = ref;
            p = p+1;
            ref.cdp = me.cdp;
            me.addDisplay('LBCB 1 Dx Load Protocol',ref,me.mainDisp.DxLoadPL1);
            ref = LoadProtocolPlot(true,me.dat,2);
            me.loadP{p} = ref;
            p = p+1;
            ref.cdp = me.cdp;
            me.addDisplay('LBCB 1 Dy Load Protocol',ref,me.mainDisp.DyLoadPL1);
            ref = LoadProtocolPlot(false,me.dat,3);
            me.loadP{p} = ref;
            p = p+1;
            ref.cdp = me.cdp;
            me.addDisplay('LBCB 2 Dx Load Protocol',ref,me.mainDisp.DxLoadPL2);
            ref = LoadProtocolPlot(false,me.dat,2);
            me.loadP{p} = ref;
            ref.cdp = me.cdp;
            me.addDisplay('LBCB 2 Dy Load Protocol',ref,me.mainDisp.DyLoadPL2);
            
            ref = ResponseTable('L1ResponseTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1ResponseTable',ref,me.mainDisp.L1ResponseTable);
            ref = ResponseTable('L2ResponseTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2ResponseTable',ref,me.mainDisp.L2ResponseTable);
            ref = AllStepsCommandTable('L1CommandTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1CommandTable',ref,me.mainDisp.L1CommandTable);
            ref = AllStepsCommandTable('L2CommandTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2CommandTable',ref,me.mainDisp.L2CommandTable);
            ref = SubstepsCommandTable('L1SubstepsTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1SubstepsTable',ref,me.mainDisp.L1SubstepsTable);
            ref = SubstepsCommandTable('L2SubstepsTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2SubstepsTable',ref,me.mainDisp.L2SubstepsTable);
            ref = LbcbReadingsTable('L1ReadingsTable',1);
            ref.cdp = me.cdp;
            me.addDisplay('L1ReadingsTable',ref,me.mainDisp.L1ReadingsTable);
            ref = LbcbReadingsTable('L2ReadingsTable',0);
            ref.cdp = me.cdp;
            me.addDisplay('L2ReadingsTable',ref,me.mainDisp.L2ReadingsTable);
            ref = ArchTable('DerivedTable');
            ref.cdp = me.cdp;
            me.addDisplay('DerivedTable',ref,me.mainDisp.DerivedTable);
            ref = StatsTable(me.stats);
            me.addDisplay('Test Statistics',ref,me.mainDisp.TestStatistics);
        end
        function yes = isDisplaying(me,name)
            ref = me.disps{me.dispIdxs.get(name)};
            yes = ref.plot.isDisplayed;
        end
        function setInput(me,steps,start)
            for p = 1:length(me.loadP)
                me.loadP{p}.setLoadP(steps,start);
            end
        end
        function closeDisplay(me,name)
            i = me.dispIdxs.get(name);
            ref = me.disps{i};
            ref.undisplayMe();
            hndl = me.checkHndls{i};
            if hndl ~= 0
                set(hndl,'Checked','off');
            end
        end
        function openDisplay(me,name)
            i = me.dispIdxs.get(name);
            ref = me.disps{i};
            ref.displayMe();
            ref.plot.isDisplayed = true;
            hndl = me.checkHndls{i};
            if hndl ~= 0
                set(hndl,'Checked','on');
            end
        end
        function updateDisplay(me,name,target)
            ref = me.disps{me.dispIdxs.get(name)};
            ref.update(target);
        end
        function updateAll(me,target)
            keys = me.dispIdxs.keys();
            lt = length(keys);
            for v = 1:lt
                name = char(keys(v));
                me.updateDisplay(name,target);
            end
        end
        function closeAll(me)
            keys = me.dispIdxs.keys();
            lt = length(keys);
            for v = 1:lt
                name = char(keys(v));
                if me.isDisplaying(name)
                    me.closeDisplay(name);
                end
            end
        end
    end
    methods (Static)
        function setMe(me)
            global mySelf;
            mySelf = me;
        end
        function dispDeleted(src,event,name) %#ok<INUSD,INUSL>
            global mySelf;
            if mySelf.dispIdxs.exists(name) == false
                return;
            end
            i = mySelf.dispIdxs.get(name);
            
            ref = mySelf.disps{i};
            ref.plot.isDisplayed = false;
            hndl = mySelf.checkHndls{i};
            if hndl ~= 0
                set(hndl,'Checked','off');
            end
        end
    end
end
