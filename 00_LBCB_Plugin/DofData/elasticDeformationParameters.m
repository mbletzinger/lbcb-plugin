classdef elasticDeformationParameters < handle
    properties
        tolerance = [];
        % Perturbation for jacobian estimation '
        pertDx  = 0.001;
        pertDz  = 0.001;
        pertRy = 0.001;
    end
end
    