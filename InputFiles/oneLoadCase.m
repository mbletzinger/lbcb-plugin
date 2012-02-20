function out = oneLoadCase(mag, num_steps, num_cycles)
% mag = 0.05;
% num_steps = 2;
% num_cycles = 3;
Dx = zeros(num_steps*4*num_cycles+1,1);

for i = 1 : num_cycles
   Dx(4*num_steps*(i-1) + 1:4*num_steps*(i-1) + num_steps + 1, 1) = linspace(0, mag, num_steps+1)';
   Dx(4*num_steps*(i-1) + num_steps + 1:4*num_steps*(i-1) +  2*num_steps + 1, 1) = linspace(mag,0, num_steps+1)';
   Dx(4*num_steps*(i-1) + 2*num_steps + 1:4*num_steps*(i-1) + 3*num_steps + 1, 1) = -linspace(0, mag, num_steps+1)';
   Dx(4*num_steps*(i-1) + 3*num_steps + 1:4*num_steps*(i-1) + 4*num_steps + 1, 1) = -linspace(mag,0, num_steps+1)';
end

out = Dx;


