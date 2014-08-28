function R = quaternionToRotationMatrix(quaternion)
%     R_alt(1, 1, :) = 2.*quaternion(:, 1).^2-1+2.*quaternion(:, 2).^2;
%     R_alt(2, 1, :) = 2.*(quaternion(:, 2).*quaternion(:, 3)-quaternion(:, 1).*quaternion(:, 4));
%     R_alt(3, 1, :) = 2.*(quaternion(:, 2).*quaternion(:, 4)+quaternion(:, 1).*quaternion(:, 3));
%     R_alt(3, 2, :) = 2.*(quaternion(:, 3).*quaternion(:, 4)-quaternion(:, 1).*quaternion(:, 2));
%     R_alt(3, 3, :) = 2.*quaternion(:, 1).^2-1+2.*quaternion(:, 4).^2;
    
    
    w = quaternion(1);
    x = quaternion(2);
    y = quaternion(3);
    z = quaternion(4);
    
n = w * w + x * x + y * y + z * z;
if n < 1e-06
    s = 0;
else
    s = 2/n;
end
wx = s * w * x; wy = s * w * y; wz = s * w * z;
xx = s * x * x; xy = s * x * y; xz = s * x * z;
yy = s * y * y; yz = s * y * z; zz = s * z * z;

R = ...
  [ ...
    1 - (yy + zz)         xy - wz          xz + wy; ...
      xy + wz     1 - (xx + zz)         yz - wx; ...
      xz - wy          yz + wx     1 - (xx + yy); ...
  ];

% [ 1 - (yy + zz)         xy - wz          xz + wy  ]
% [      xy + wz     1 - (xx + zz)         yz - wx  ]
% [      xz - wy          yz + wx     1 - (xx + yy) ]



%     phi = atan2(R(3, 2, :),  R(3, 3, :) );
%     theta = -atan(R(3, 1, :) ./ sqrt(1-R(3, 1, :).^2) );
%     psi = atan2(R(2, 1, :),  R(1, 1, :) );
%     euler = [phi(1, :)' theta(1, :)' psi(1, :)'];
end