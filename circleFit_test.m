
% center = [3; 3; 3]
% normal = [1; 1; 0]; normal = normVector(normal)
% radius = 3

center = randn(3, 1)
normal = randn(3, 1); normal = normVector(normal)
radius = randn + 2

noise_sigma = 0.1;

number_of_data_points = 500;
circle_param = randn(number_of_data_points, 1);
circle_plane = [cos(linspace(0, 2*pi, 500)')*radius, sin(linspace(0, 2*pi, 500)')*radius, zeros(number_of_data_points, 1)];
circle_plane_noisy = [cos(circle_param)*radius, sin(circle_param)*radius, zeros(number_of_data_points, 1)] + noise_sigma * randn(number_of_data_points, 3);


omega = cross(normal, [0; 0; 1]);
theta = subspace(normal, [0; 0; 1]);
rotation = rodrigues(omega, theta);
transformation = [rotation, center; 0 0 0 1];
circle = (transformation * [circle_plane ones(number_of_data_points, 1)]')';
circle_noisy = (transformation * [circle_plane_noisy ones(number_of_data_points, 1)]')';

[center_est, normal_est, radius_est, V] = circleFit(circle_noisy(:, 1:3));


% transform back to 3d
rotation = [V normal_est];
transformation = [rotation center_est(1:3); 0 0 0 1];
circle_reconstr_plane = [cos(0:0.01:2*pi)*radius_est; sin(0:0.01:2*pi)*radius_est; zeros(size(0:0.01:2*pi)); ones(size(0:0.01:2*pi))];
circle_reconstr = transformation * circle_reconstr_plane;




figure; axes; hold on; axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
plot3(circle_noisy(:, 1), circle_noisy(:, 2), circle_noisy(:, 3), 'x')
plot3(circle(:, 1), circle(:, 2), circle(:, 3))
plot3(circle_reconstr(1, :), circle_reconstr(2, :), circle_reconstr(3, :))
plot3(center_est(1), center_est(2), center_est(3), 'rx')



subspace(normal, normal_est)
