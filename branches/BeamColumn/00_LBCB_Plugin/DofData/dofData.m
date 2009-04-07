classdef dofData < handle
    properties
        disp = zeros(6,1);               % Displacement at each step, Num_DOFx1
        forc = zeros(6,1);               % Force at each step, Num_DOFx1
    end
end