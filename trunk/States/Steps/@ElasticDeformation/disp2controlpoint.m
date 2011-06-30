function cmd = disp2controlpoint(d,xpin,xfix,xcurrent,cmdlast,imode,opt)
% disp2controlpoint is to calculate the position of the current control 
% point based on the local measurements from LVDTs or linear pots or the 
% free pin points
% inputs: d        - measurements from LVDTs or linear pots. This variable
%                    will be always the total difference between the 
%                    initial reading and the current reading.
%         xcurrent - current pin locations (x,y,z). It is location by
%                    number of external sensors, i.e., size(current) = [3 #
%                    of sensors]
%         xpin     - initial free-end pins' locations, which have the same
%                    definition as xcurrent
%         xfix     - fixed-end pins' locations, which have the same
%                    definition as xpin and xcurrent
%         cmdlast  - the previous commands for the control point
%         imode    - the case of imode = 1 awlays starts from the initial
%                    xpin location and considers the current measurements 
%                    only. The case of imode = 2 has the same features of 
%                    imode = 1 but it also inculdes the current pin 
%                    locations in the algorithm (not developed). 
%                    The case of imode = 3 always starts from 
%                    the previous step along with only measurements only. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
% Notice: this method assumes that the initial location of the control
%         point is at [0 0 0]. If the control point does not start at zero,
%         then one should consider offsets for all locations. 

%------------------
% optimization setting
%------------------
UB = [30*ones(1,3) pi/5*ones(1,3)]';
LB = -UB;

%------------------
% obtain cmd
%------------------
switch imode
    case 1
        cmdtemp = lsqnonlin(@(cmd) x2cmd_eval(cmd,xcurrent,xpin,xfix,d),cmdlast',LB,UB,opt);
        cmd = cmdtemp';
    case 3
        cmdtemp = lsqnonlin(@(cmd) x2cmd_eval2(cmd,xpin,xfix,d,cmdlast'),zeros(6,1),LB,UB,opt);
        cmd = cmdtemp';
end