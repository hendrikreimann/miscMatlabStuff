function angles = eulerAnglesFromRotationMatrixZXY(R)
%
% ---------------------------------------------------------------------
%
% eulerAnglesFromRotationMatrixZXY.m
%
% calculates three euler angles from a rotation matrix
% 
% Hendrik Reimann, 2011
% Institut fuer Neuroinformatik
% Ruhr-University Bochum
% hendrikreimann@gmail.com
%
% ---------------------------------------------------------------------
%
% Input
% R = 3 x 3 rotation matrix
%
% Output
% angles = ZXY euler angles
%
% ---------------------------------------------------------------------

if (abs(R(3, 2)) ~= 1)
    theta_2 = asin(R(3, 2));
    theta_3 = atan2(-R(3, 1), R(3, 3));
    theta_1 = atan2(-R(1, 2), R(2, 2));
else
    theta_3 = 0;
    if (R(3, 2) == 1)
        theta_2 = pi/2;
        theta_1 = atan2(R(1, 3), R(1, 1));
    else
        theta_2 = -pi/2;
        theta_1 = atan2(-R(1, 3), -R(1, 1));
    end
end
angles = [theta_1; theta_2; theta_3];
