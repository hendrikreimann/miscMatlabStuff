% fits a circle to a 3d point cloud

function [center, normal, radius, V] = circleFit(data)

    options = optimset ...
        ( ...
            'GradObj', 'off', ...
            'Display','off', ...
            'LargeScale', 'off', ...
            'DerivativeCheck', 'on', ...
            'UseParallel', 'always' ...
        );
    number_of_data_points = size(data, 1);
        
    % find the plane
    [normal, V, p] = affine_fit(data);
    
    % transform to this plane
    data_plane = (V' * (data' - repmat(p', 1, number_of_data_points)))';
    
    % fit circle in the plane
    center_init = mean(data_plane)';
    center_plane = fminunc(@objfun_circle, center_init, options);
    
    % find radius
    point_to_center = repmat(center_plane', number_of_data_points, 1) - data_plane;
    radius = mean(sum(point_to_center.^2, 2)).^0.5;
    
    % transform back to 3d
    rotation = [V normal];
    transformation = [rotation p'; 0 0 0 1];
    center = transformation*[center_plane; 0; 1];
    
    
    
    
    % plot
    circle_plane = [cos(0:0.01:2*pi)*radius+center_plane(1); sin(0:0.01:2*pi)*radius+center_plane(2); zeros(size(0:0.01:2*pi)); ones(size(0:0.01:2*pi))];
    circle = transformation*circle_plane;
    
    
%     figure; axes; hold on; axis equal;
%     plot(data_plane(:, 1), data_plane(:, 2), 'x')
%     plot(center_plane(1), center_plane(2), 'rx')
%     plot(circle_plane(1, :), circle_plane(2, :), 'r');
%     
%     figure; axes; hold on; axis equal;
%     plot3(data(:, 1), data(:, 2), data(:, 3), 'x')
%     plot3(center(1), center(2), center(3), 'rx');
%     plot3(circle(1, :), circle(2, :), circle(3, :), 'r');
    
    







    function f = objfun_circle(center)
        
        
        point_to_center = repmat(center', number_of_data_points, 1) - data_plane;
        radius = (sum(point_to_center.^2, 2)).^0.5;
        
        meanRadius = mean(radius, 1);
        error = radius - meanRadius;
        f = sum(sum(error.^2));
    end







end