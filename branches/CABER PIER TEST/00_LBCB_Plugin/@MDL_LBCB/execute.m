function obj = execute(obj)
% =====================================================================================================================
% This method sends execute commands.
%
% Written by    7/21/2006 2:31AM OSK
% Last updated  1/17/2007 11:35PM OSK, KSP
% Last updated  1/20/2007 KSP for NHCPSim1D
% =====================================================================================================================
%for i=1:length(obj)
%    try,
%      updateGUI_Txt(obj,'Executing proposed step ...');
%        switch lower(obj.protocol)
%            case {'ntcp'}                                   
%                if (obj.CheckRelax == 1)                 % execute immediately after receiving propose command.
%                    [accepted msg] = CheckRelax(obj);
%                    if accepted==0
%                        dispmsg(msg);
%                        %uiwait(msgbox(msg,'Relaxation check','warn','modal'));
%                        switch questdlg(msg,'Relaxation check','Continue','Abort','Continue');
%                          case {'Abort'}
%                            error('UI-SimCor terminated abnormally.');
%                          otherwise
%                        end
%                        
%                    end
%                end
%                execute(obj.Comm_obj,obj.TransID,-1);
%
%            case {'tcpip'}
%                % Do nothing. Test will be executed automatically upon receiving target data.
%
%            case {'labview1'}
%                if (obj.CheckRelax == 1)
%                    [accepted msg] = CheckRelax(obj);
%                    if accepted==0
%                        dispmsg(msg);
%                        %uiwait(msgbox(msg,'Relaxation check','warn','modal'));
%                        switch questdlg(msg,'Relaxation check','Continue','Abort','Continue');
%                          case {'Abort'}
%                            error('UI-SimCor terminated abnormally.');
%                          otherwise
%                        end
%                    end
%                end

                send_str = sprintf('execute\t%s',obj.TransID);
                Sendvar_LabView(obj,send_str);
                Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);

%            case {'labview2'}
%                % Do nothing. Test will be executed automatically upon receiving target data.
%            case {'openfresco1d'}
%                % Do nothing. Test will be executed automatically upon receiving target data.
%            case {'nhcp'}
%                % Do nothing. Test will be executed automatically upon receiving target data.
%
%        end
%        updateGUI_Txt(obj,'Execution complete.');
      obj.curState = 2;
      
%    catch,
%        switch lower(obj.protocol)
%            case {'ntcp'}
%                try,        % in case ntcp protocol, cancel the proposal.
%                    cancel(obj.Comm_obj,obj.TransID);
%                end
%            case {'tcpip'}
%            case {'labview1'}
%            case {'labview2'}
%            case {'openfresco1d'}
%            case {'nhcp'}
%        end
%        errstr = sprintf('Error sending Execute command.\nUnable to send to remote site, %s', obj.name);
%        errmsg(errstr);
%    end;
%end