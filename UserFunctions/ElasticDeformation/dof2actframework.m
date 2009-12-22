function lengths = dof2act(deltas,v0,p0,q0)
% Note: deltas must be a vector of displacements: [dx,dy,dz,rx,ry,rz]

%% Defining displacements calculating rotational matrix

% Calculating rotational matrix using Roll-Pitch-Yaw convention
psi1 = [cos(deltas(6))  -sin(deltas(6)) 0
        sin(deltas(6))  cos(deltas(6))  0
        0               0               1];

psi2 = [cos(deltas(5))  0               sin(deltas(5))
        0               1  0
        -sin(deltas(5)) 0               cos(deltas(5))];

psi3 = [1      0               0
        0      cos(deltas(4))  -sin(deltas(4))
        0      sin(deltas(4))  cos(deltas(4))];

psi = psi1*psi2*psi3;


%% Processing displacement data to give actuator length data

lengths = zeros(1,size(p0,2));
for i = 1:size(p0,2)
    r0 = p0(:,i) - v0;
    pin2pin = deltas(1:3) - (eye(3) - psi)*r0 + p0(:,i) - q0(:,i);
    lengths(i) = norm(pin2pin);
end