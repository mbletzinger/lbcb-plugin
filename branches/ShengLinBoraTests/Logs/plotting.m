clear; clc; close all

% checks={'dx','dz','rx','ry','comb','comb_corr1','comb_corr2'};
% checks={'2010_06_02_15_17_45','2010_06_02_16_37_36'};
% checks={'2010_06_02_17_47_54','2010_06_02_18_09_09','2010_06_03_10_37_41'};
% checks={'2010_06_04_16_52_13'};
% checks={'2010_06_04_17_20_20'};
% checks={'2010_06_07_11_16_34'};
% checks={'2010_06_07_11_55_13'};
% checks={'2010_06_09_16_00_08'};
% checks={'2010_06_09_16_37_52'};
% checks={'2010_06_09_17_31_25'};
checks={'2010_06_13_21_09_24'};


colorcode={'b','r','k','m'};
for ii=1:length(checks);
    tline=1;
    fid1=fopen(['ElasticDefReadings_',checks{ii},'.txt']);
    fid2=fopen(['LbcbReadings_',checks{ii},'.txt']);
    tlinedump=fgets(fid1); tlinedump=fgets(fid2);
    q=1; clear ed lbcb
    while tline~=-1;
        tline=fgets(fid1);
        if tline==-1; break; end
        ed(q,:)=str2num(tline);
        tline=fgets(fid2);
        lbcb(q,:)=str2num(tline);
        q=q+1;        
    end
%     figure(99); hold on; plot(1:size(ed,1),ed(:,4),colorcode{ii});
%     figure(100); hold on; plot(1:size(ed,1),ed(:,5),colorcode{ii});
%     figure(101); hold on; plot(1:size(ed,1),ed(:,6),colorcode{ii});
%     figure; plot(1:size(ed,1),ed(:,4),1:size(ed,1),ed(:,5),'--r',1:size(ed,1),ed(:,6),'-.k');
%     figure; plot(1:size(ed,1),ed(:,7),1:size(ed,1),ed(:,8),'--r',1:size(ed,1),ed(:,9),'-.k');
%     figure; plot(1:size(ed,1),lbcb(:,4),1:size(ed,1),lbcb(:,5),'--r',1:size(ed,1),lbcb(:,6),'-.k');
%     figure; plot(1:size(ed,1),lbcb(:,7),1:size(ed,1),lbcb(:,8),'--r',1:size(ed,1),lbcb(:,9),'-.k');        
    
    figure; plot(1:size(ed,1),lbcb(:,4),1:size(ed,1),ed(:,4),'--r');
    figure; plot(1:size(ed,1),lbcb(:,5),1:size(ed,1),ed(:,5),'--r');
    figure; plot(1:size(ed,1),lbcb(:,6),1:size(ed,1),ed(:,6),'--r');
    figure; plot(1:size(ed,1),lbcb(:,7),1:size(ed,1),ed(:,7),'--r');
    figure; plot(1:size(ed,1),lbcb(:,8),1:size(ed,1),ed(:,8),'--r');
    figure; plot(1:size(ed,1),lbcb(:,9),1:size(ed,1),ed(:,9),'--r');    

%     figure; plot(lbcb(:,4),lbcb(:,10));
%     figure; plot(lbcb(:,5),lbcb(:,11));
%     figure; plot(lbcb(:,6),lbcb(:,12));
end
fclose('all');

