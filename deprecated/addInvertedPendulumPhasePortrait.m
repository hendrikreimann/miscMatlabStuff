function addInvertedPendulumPhasePortrait(target_axes, orbit_color, axes_limits, number_of_values)

    %% define and solve system
    T_total = 3;
    time_step = 0.001;

    % for fixed p
    z_c = 0.814;
    g = 9.81;
    omega = sqrt(g/z_c);
    p = 0;

    % fill initial conditions
%     number_of_values = 20;
    % number_of_values = 50;
    extension = .2;
    
    
    offset = axes_limits(2);
    
    sample_logspace = logspace(1, 2, number_of_values+2);
    logspace_transformed = (sample_logspace/90-10/90) * offset;
    x_basis = logspace_transformed(2:end-1)';
    
    x = ...
      [ ...
        -x_basis + offset; ...
        x_basis - offset; ...
        -(ones(number_of_values, 1)*offset); ...
        (ones(number_of_values, 1)*offset); ...
      ];
    v = ...
      [ ...
        -(ones(number_of_values, 1)*offset) * omega; ...
        (ones(number_of_values, 1)*offset) * omega; ...
        (-x_basis + offset) * omega; ...
        (x_basis - offset) * omega; ...
      ];
    
    
    
    
    x_old = ...
      [ ...
        linspace(-extension, extension, number_of_values/2)' - offset; ...
        linspace(-extension, extension, number_of_values/2)' + offset ...
      ];
    v_old = ...
      [ ...
        (linspace(-extension, extension, number_of_values/2)' + offset) * omega; ...
        (linspace(-extension, extension, number_of_values/2)' - offset) * omega ...
      ];
    a = omega^2*(x-p);

    time = time_step : time_step : T_total;
    number_of_time_steps = length(time);
    xi = x + 1/omega * v;
    xiDot = omega*(xi-p);

    total_values = length(x);
    x_trajectory = zeros(total_values, number_of_time_steps);
    v_trajectory = zeros(total_values, number_of_time_steps);
    a_trajectory = zeros(total_values, number_of_time_steps);
    xi_trajectory = zeros(total_values, number_of_time_steps);
    xiDot_trajectory = zeros(total_values, number_of_time_steps);

    x_trajectory(:, 1) = x;
    v_trajectory(:, 1) = v;
    a_trajectory(:, 1) = a;
    xi_trajectory(:, 1) = xi;
    xiDot_trajectory(:, 1) = xiDot;







    for i_time = 2 : number_of_time_steps
        % euler step
        x = x + time_step*v + 1/2*time_step^2*a;
        v = v + time_step*a;

        % calculate dependables
        a = omega^2*(x - p);
        xi = x + v/omega;
        xiDot = omega*(xi - p);

        % store
        x_trajectory(:, i_time) = x;
        v_trajectory(:, i_time) = v;
        a_trajectory(:, i_time) = a;
        xi_trajectory(:, i_time) = xi;
        xiDot_trajectory(:, i_time) = xiDot;


    end


    cmp = [    0.2081    0.1663    0.5292; ...
                0.0060    0.4086    0.8828; ...
                0.0641    0.5570    0.8240; ...
                0.0590    0.6838    0.7254; ...
                0.3953    0.7459    0.5244; ...
                0.7525    0.7384    0.3768; ...
                0.9990    0.7653    0.2164; ...
                0.9763    0.9831    0.0538; ...
                ];
    if nargin < 2
        orbit_color = cmp(3, :);
    end

    save_path = [pwd filesep '..' filesep 'raw'];

    %% light

    linewidth_orbit = 1;
    linewidth_stable = 1;
    for i_value = 1 : total_values
        plot(target_axes, x_trajectory(i_value, :), v_trajectory(i_value, :)*1/omega, 'color', orbit_color, 'linewidth', linewidth_orbit)
    end
    plot(target_axes, [-1 1]*10, [-1 1]*10, 'color', orbit_color, 'linewidth', linewidth_stable)
    plot(target_axes, [-1 1]*10, [1 -1]*10, 'color', orbit_color, 'linewidth', linewidth_stable)
end






