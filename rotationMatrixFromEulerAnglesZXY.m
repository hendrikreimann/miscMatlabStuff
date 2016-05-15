function rotationMatrix = rotationMatrixFromEulerAnglesZXY(varargin)

if nargin == 1
    psi = varargin{1}(1);
    phi = varargin{1}(2);
    gamma = varargin{1}(3);
elseif nargin == 3
    psi = varargin{1};
    phi = varargin{2};
    gamma = varargin{3};
end

R_z = expAxis([0; 0; 1], psi);
R_x = expAxis([1; 0; 0], phi);
R_y = expAxis([0; 1; 0], gamma);

rotationMatrix = R_z * R_x * R_y;
