function q = rotateZ(p,orig,rot)
% Rotate point around origin with angle of rot

% p        : (3x1) coordinate, point to rotate
% orig     : (3x1) coordinate, origin of rotation
% rot      : sclar, rotation angle

T_Rot = [cos(rot)   sin(rot)   0
         -sin(rot)    cos(rot)   0
         0           0          1];
q = T_Rot*(p-orig) + orig;
