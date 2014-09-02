function sensor_pinloc2

f = figure('Visible','on','Position',[150,100,1000,600],'Name','External Sensor Free-pin Locations');


%------------------
% all parameters
%------------------
alldata.num = 0;
alldata.ind_numsensor = 0;
alldata.ind_redo = 0;
alldata.ind_update = 0;
alldata.ind_calculate = 0;
alldata.ind_saveinput = 0;
alldata.ind_saveoutput = 0;

%------------------
% Input # of sensors
%------------------
Hnumsensor_title = uicontrol('Style','text','String','# of sensors','pos',[10 520 100 20],'visible','on');
Hnumsensor = uicontrol('Style','edit','String',num2str(alldata.num),'pos',[10 500 100 20],'Handlevisibility','off','Callback',{@hnumsensor_Callback});

%------------------
% Table-I
%------------------
colname = {'x-fix','y-fix','z-fix','x-pin','y-pin','z-pin','sensitivity','readings','LVDT-length'};
alldata.numcol = length(colname);
coledit = true(1,length(colname));
colformat = cell(1,length(colname));
for j = 1:length(colname)   
    colformat(1,j) = {'numeric'};
end
rowname = cell(1,alldata.num);
for i = 1:alldata.num
    rowname(i) = {num2str(i)};
end
backcolor = 1/255*[220 220 220;245 222 179];
Hinputable1 = uitable('pos',[120 350 800 200],'ColumnName',colname,'ColumnFormat',colformat,...
                      'ColumnEditable',coledit,'RowName',rowname,'RowStriping','on',...
                      'BackgroundColor',backcolor,...
                      'SelectionHighlight','off','CellEditCallback',{@hinputable1_Callback});

%------------------
% Table II
%------------------
colname = {'current readings'};
alldata.numcol2 = length(colname);
coledit = true(1);
colformat = {'numeric'};
rowname = cell(1,alldata.num);
for i = 1:alldata.num
    rowname(i) = {num2str(i)};
end
backcolor = 1/255*[220 220 220;245 222 179];
Hinputable2 = uitable('pos',[20 50 125 200],'ColumnName',colname,'ColumnFormat',colformat,...
                      'ColumnEditable',coledit,'RowName',rowname,'RowStriping','on',...
                      'BackgroundColor',backcolor,...
                      'SelectionHighlight','off','CellEditCallback',{@hinputable2_Callback});
                  
%------------------
% Table III
%------------------
colname = {'xnew-pin','ynew-pin','znew-pin', 'priority'};
alldata.numcol3 = length(colname);
coledit = false(1,length(colname));
colformat = cell(1,length(colname));
for j = 1:length(colname)   
    colformat(1,j) = {'numeric'};
end
rowname = cell(1,alldata.num);
for i = 1:alldata.num
    rowname(i) = {num2str(i)};
end
backcolor = 1/255*[220 220 220;245 222 179];
Hinputable3 = uitable('pos',[300 50 345 200],'ColumnName',colname,'ColumnFormat',colformat,...
                      'ColumnEditable',coledit,'RowName',rowname,'RowStriping','on',...
                      'BackgroundColor',backcolor,...
                      'SelectionHighlight','off','Visible','off');

%------------------
% load data
%------------------
ind_file = exist('inputdatafile.mat');
if ind_file == 2
    temp = load('inputdatafile.mat');
    inputdata = temp.inputdata;
    set(Hinputable1,'Data',num2cell(inputdata(:,1:end-1)));
    set(Hinputable2,'Data',num2cell(inputdata(:,end)));
    alldata.num = size(inputdata,1);
    set(Hnumsensor,'String',num2str(alldata.num));
    %==
    rowname = cell(1,alldata.num);
    for i = 1:alldata.num
        rowname(i) = {num2str(i)};
    end
    set([Hinputable1,Hinputable2,Hinputable3],'RowName',rowname);
end
 
                  
%------------------
% redo button
%------------------
Hredo = uicontrol('Style','pushbutton','String','Redo','pos',[20,300,100,20],'Callback',{@hredo_Callback});

%------------------
% update and calculate button
%------------------
Hupdate = uicontrol('Style','pushbutton','String','Update','pos',[120,300,100,20],'Callback',{@hupdate_Callback});
Hcalculate = uicontrol('Style','pushbutton','String','Calculate','pos',[220,300,100,20],'Callback',{@hcalculate_Callback},'Visible','off');

%------------------
% save input button
%------------------
Hsaveinput = uicontrol('Style','pushbutton','String','Save Input','pos',[420,300,100,20],'Callback',{@hsaveinput_Callback},'Visible','off');
Hsaveoutput = uicontrol('Style','pushbutton','String','Save Output','pos',[520,300,100,20],'Callback',{@hsaveoutput_Callback},'Visible','off');

%------------------
% Adjustable Window
%------------------
set([f,Hnumsensor_title,Hnumsensor,Hinputable1,Hinputable2,Hinputable3,Hredo,Hupdate,Hcalculate,Hsaveinput,Hsaveoutput],'Units','normalized');

%------------------
% All Callback functions
%------------------
    function hnumsensor_Callback(hObject, eventdata)
        alldata.num = str2double(get(hObject,'string'));
        %==
        rowname = cell(1,alldata.num);
        for i = 1:alldata.num
            rowname(i) = {num2str(i)};
        end
        data = get(Hinputable1,'Data');
        if size(data,1) == 0
            data = cell(alldata.num,alldata.numcol);
        elseif size(data,1) > alldata.num
            temp = cell(alldata.num,alldata.numcol);
            temp(1:alldata.num,1:size(data,2)) = data(1:alldata.num,:);
            data = temp;
        else
            temp = cell(alldata.num,alldata.numcol);
            temp(1:size(data,1),1:size(data,2)) = data;
            data = temp;
        end
        set(Hinputable1,'Data',data);
        set(Hinputable1,'RowName',rowname);
        %==
        data = get(Hinputable2,'Data');
        if size(data,1) == 0
            data = cell(alldata.num,alldata.numcol2);
        elseif size(data,1) > alldata.num
            temp = cell(alldata.num,alldata.numcol2);
            temp(1:alldata.num,1:size(data,2)) = data(1:alldata.num,:);
            data = temp;
        else
            temp = cell(alldata.num,alldata.numcol2);
            temp(1:size(data,1),1:size(data,2)) = data;
            data = temp;
        end
        set(Hinputable2,'Data',data);
        set(Hinputable2,'RowName',rowname);
        %==
        set(Hinputable3,'RowName',rowname);
        %==
        temp = get(hObject,'Max')-get(hObject,'Min');
        if temp > 1
            error('# of sensors should only contain one entry');
        end
        %==
        set(Hsaveoutput,'Visible','off');
        set(Hsaveinput,'Visible','off');
    end

    function hinputable1_Callback(obj,event)
        tabledata = get(obj,'Data');
        tabledata{event.Indices(1),event.Indices(2)} = event.NewData;
        set(obj,'Data',tabledata)
        %==
        set(Hsaveoutput,'Visible','off');
        set(Hsaveinput,'Visible','off');
    end

    function hinputable2_Callback(obj,event)
        tabledata = get(obj,'Data');
        tabledata{event.Indices(1),event.Indices(2)} = event.NewData;
        set(obj,'Data',tabledata)
        %==
        set(Hsaveoutput,'Visible','off');
        set(Hsaveinput,'Visible','off');
    end

    function hredo_Callback(obj,event)
        alldata.ind_redo = get(obj,'Value');
        set(Hinputable1,'ColumnEditable',true(1,alldata.numcol));
        set(Hinputable2,'ColumnEditable',true(1,alldata.numcol2));
        set(Hnumsensor,'Visible','on');
        set(Hinputable3,'Visible','off');
        set(Hsaveoutput,'Visible','off');
        set(Hsaveinput,'Visible','off');
        set(Hcalculate,'Visible','off');
        alldata.ind_update = 0;
        alldata.ind_calculate = 0;
    end

    function hupdate_Callback(obj,event)
        alldata.ind_update = get(obj,'Value');
        set(Hinputable1,'ColumnEditable',false(1,alldata.numcol));
        set(Hinputable2,'ColumnEditable',false(1,alldata.numcol2));
        set(Hinputable3,'Visible','off');
        set(Hnumsensor,'Visible','off');
        set(Hsaveinput,'Visible','on');
        set(Hcalculate,'Visible','on');
        alldata.ind_calculate = 0;
    end

    function hsaveinput_Callback(obj,event)
        alldata.ind_saveinput = get(obj,'Value');
        if alldata.ind_update >= 1
            datatemp1 = cell2mat(get(Hinputable1,'Data'));
            datatemp2 = cell2mat(get(Hinputable2,'Data'));
            %==
            inputdata = [datatemp1(1:alldata.num,1:alldata.numcol),datatemp2(1:alldata.num,1:alldata.numcol2)];
            %==
            save('inputdatafile','inputdata');
        end
    end

    function hcalculate_Callback(obj,event)
        alldata.ind_calculate = get(obj,'Value');
        if alldata.ind_update >= 1
           datatemp1 = cell2mat(get(Hinputable1,'Data'));
           ns = alldata.num;
           xfix = datatemp1(1:ns,1:3);
           xpin = datatemp1(1:ns,4:6);
           sens = datatemp1(1:ns,7)';
           reading_oil_off = datatemp1(1:ns,8)';
           LVDT_length_oil_off = datatemp1(1:ns,9)';
           %==
           datatemp2 = cell2mat(get(Hinputable2,'Data'));
           reading_oil_on = datatemp2(1:ns,1)';
           %==
           temp_len_change = (reading_oil_on-reading_oil_off).*sens;
           dold1 = LVDT_length_oil_off'+temp_len_change';
           %==
           dold2 = zeros(ns*(ns-1)/2,1);
           istep = 1;
           for i = 1:(ns-1)
               for j = (i+1):ns
                   dold2(istep) = norm(xpin(i,:)-xpin(j,:));
                   istep = istep+1;
               end
           end
           %==
           dold3 = zeros(ns*(ns-1)*(ns-2)/6*3,1);
           istep = 1;
           for i = 1:(ns-2)
               for j = (i+1):(ns-1)
                   for k = (j+1):ns
                       vec1 = xpin(i,:)-xpin(j,:);
                       vec2 = xpin(i,:)-xpin(k,:);
                       vec3 = xpin(j,:)-xpin(k,:);
                       temp = [dot(vec1,vec2);dot(vec1,vec3);dot(vec2,vec3)];
                       dold3(1+(istep-1)*3:istep*3,1) = temp;
                       istep = istep+1;
                   end
               end
           end
           %==
           dtotal = [dold1;dold2;dold3];
           %==
           opt = optimset('MaxFunEvals',5000,'MaxIter',10000,'TolFun',1e-32,'TolX',1e-64,...
               'Display','iter','Jacobian','off');
           %==
           x0 = zeros(3*ns,1);
           %==
           max_x = max(abs(xfix),[],1);
           LB = kron(ones(ns,1),-max_x');
           UB = kron(ones(ns,1),max_x');
           %==
           xtemp = lsqnonlin(@(x) pinfreeini1(x,xfix',xpin',dtotal),x0,LB,UB,opt);
           %==
           opt = optimset('MaxFunEvals',500,'MaxIter',10000,'TolFun',1e-32,'TolX',1e-64,...
               'Algorithm',{'levenberg-marquardt',0.75},'Display','iter','Jacobian','on','ScaleProblem','Jacobian');
           %==
           x0 = xtemp;
           LB = [];
           UB = [];
           %==
           xtemp = lsqnonlin(@(x) pinfreeini1(x,xfix',xpin',dtotal),x0,LB,UB,opt);
           %==
           updates = reshape(xtemp,3,ns)';
           xpin_current = zeros(ns,4);
           xpin_current(:,1:3) = updates + xpin;
           [~, I] = sort(abs(updates),'descend');
           difforder = sum(I,2);
           [~, I2] = sort(difforder);
           xpin_current(:,4) = I2;
           %==
           set(Hinputable3,'Data',num2cell(xpin_current));
           set(Hinputable3,'Visible','on');
           set(Hsaveoutput,'Visible','on');
        end
    end

    function hsaveoutput_Callback(obj,event)
        alldata.ind_saveoutput = get(obj,'Value');
        if alldata.ind_calculate >= 1
            datatemp1 = cell2mat(get(Hinputable3,'Data'));
            %==
            fid = fopen('Pinoutputfile.txt','w');
            fprintf(fid,'%9.6f\t%9.6f\t%9.6f\r\n',datatemp1');
            fclose(fid);
        end
    end


%------------------
% Optimization function
%------------------
    function [fx,Jac] = pinfreeini1(x,xfix,xpin,dtotal)
        
        %------------------
        % initial values
        %------------------
        ns = size(xfix,2);
        %==
        x = reshape(x,3,ns)+xpin;
        
        %------------------
        % obtain all lengths
        %------------------
        dtemp1 = sqrt(diag((x-xfix)'*(x-xfix)));
        dtemp2 = zeros(ns*(ns-1)/2,1);
        %~~
        istep = 1;
        for i = 1:(ns-1)
            for j = (i+1):ns
                dtemp2(istep) = norm(x(:,i)-x(:,j));
                istep = istep+1;
            end
        end
        %~~
        dtemp3 = zeros(ns*(ns-1)*(ns-2)/6*3,1);
        istep = 1;
        for i = 1:(ns-2)
            for j = (i+1):(ns-1)
                for k = (j+1):ns
                    vec1 = x(:,i)-x(:,j);
                    vec2 = x(:,i)-x(:,k);
                    vec3 = x(:,j)-x(:,k);
                    temp = [dot(vec1,vec2);dot(vec1,vec3);dot(vec2,vec3)];
                    dtemp3(1+(istep-1)*3:istep*3,1) = temp;
                    istep = istep+1;
                end
            end
        end
        %~~
        dnow = [dtemp1;dtemp2;dtemp3];
        
        %------------------
        % Evaluation function
        %------------------
        fx = dnow-dtotal;
        
        
        %------------------
        % Jacobian
        %------------------
        Jac = zeros(length(fx),ns*3);
        dx = 0.001;%0.01
        %==
        for i = 1:ns
            for j = 1:3
                ind = j + (i-1)*3;
                %==
                xtemp = xpin;
                xtemp(ind) = dx + xtemp(ind); %0.001
                %         dxtemp = xtemp(ind);
                xtemp = reshape(xtemp,3,ns);
                %==
                dnew1 = zeros(ns,1);
                dnew1(i) = (xtemp(j,i) - xfix(j,i)) / norm(xtemp(:,i)-xfix(:,i));
                %==
                dnew2 = zeros(ns*(ns-1)/2,1);
                istep = 1;
                for ii = 1:(ns-1)
                    for jj = (ii+1):ns
                        if i == ii
                            dnew2(istep) = (xtemp(j,ii)-xtemp(j,jj))/norm(xtemp(:,ii)-xtemp(:,jj));
                        end
                        if i == jj
                            dnew2(istep) = -(xtemp(j,ii)-xtemp(j,jj))/norm(xtemp(:,ii)-xtemp(:,jj));
                        end
                        istep = istep + 1;
                    end
                end
                %==
                dnew3 = zeros(ns*(ns-1)*(ns-2)/6*3,1);
                istep = 1;
                for ii = 1:(ns-2)
                    for jj = (ii+1):(ns-1)
                        for kk = (jj+1):ns
                            temp = zeros(3,1);
                            if i == ii
                                temp(1) = 2*xtemp(j,ii) - (xtemp(j,jj)+xtemp(j,kk));
                                temp(2) = xtemp(j,jj)-xtemp(j,kk);
                                temp(3) = xtemp(j,jj)-xtemp(j,kk);
                            end
                            if i == jj
                                temp(1) = xtemp(j,kk) - xtemp(j,ii);
                                temp(2) = -2*xtemp(j,jj) + xtemp(j,ii) + xtemp(j,kk);
                                temp(3) = xtemp(j,ii) - xtemp(j,kk);
                            end
                            if i == kk
                                temp(1) = xtemp(j,jj) - xtemp(j,ii);
                                temp(2) = xtemp(j,jj) - xtemp(j,ii);
                                temp(3) = 2*xtemp(j,kk) - (xtemp(j,ii) + xtemp(j,jj));
                            end
                            dnew3(1+(istep-1)*3:istep*3,1) = temp;
                            istep = istep + 1;
                        end
                    end
                end
                Jac(:,ind) = [dnew1;dnew2;dnew3];
            end
        end
    end

%------------------
% End of this gui
%------------------
end



