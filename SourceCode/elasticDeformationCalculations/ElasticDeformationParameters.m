classdef ElasticDeformationParameters < handle
    properties
        % Allowable tolerance for jacobian updates vector size is the number of
        % external transducers
        tolerance = []; %config
        % Perturbation for jacobian estimation '
        pertD  = [0.001 0.001 0.001]; %config
    end
end
    