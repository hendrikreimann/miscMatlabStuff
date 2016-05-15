function timeDerivative = deriveByTime(x, time)
    % disable warnings
    warning_id = 'MATLAB:chckxy:IgnoreNaN';
    warning_state_old = warning('query', warning_id);
    warning('off', warning_id)
    
    if size(x, 2) > 1
        timeDerivetive = zeros(size(x));
        for i_dim = 1 : size(x, 2)
            timeDerivative(:, i_dim) = deriveByTime(x(:, i_dim), time);
        end
        return
    end

    % check whether time is a vector or a scalar
    if length(time) == 1
        time = (1 : length(x))' * time;
    end
    dt = diff(time);
    dx = diff(x);
    derivative = dx./dt;

    % resample
    time_resampling = time(1:end-1) + dt*0.5;
    derivative_resampled = spline(time_resampling, derivative, time);
    
    % remove NaN entries
    derivative_resampled(isnan(x)) = NaN;
    
%     figure; hold on;
%     plot(time_resampling, derivative, 'linewidth', 2);
%     plot(time, derivative_resampled)
    
    
    timeDerivative = derivative_resampled;
    
    % re-enable warnings if they were enabled before
    if strcmp(warning_state_old.state, 'on')
        warning('on', warning_id);
    end
end

