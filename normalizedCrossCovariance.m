% calculate the normalized cross covariance between two signals

function [r, tau_time] = normalizedCrossCovariance(x, y, samplingRate, intervalStart, intervalEnd)
% x = first signal
% y = second signal
% tau = time interval (seconds)
% samplingRate = sampling rate of the data

% determine interval limits in time steps
interval_start_time_step = ceil(intervalStart * samplingRate);
interval_end_time_step = floor(intervalEnd * samplingRate);

% mean-center the data
x_mean_free = x - mean(x);
y_mean_free = y - mean(y);

tau_time_step = interval_start_time_step : interval_end_time_step;
tau_time = tau_time_step * 1 / samplingRate;
number_of_time_steps = length(x);
number_of_lags = length(tau_time_step);
r = zeros(1, number_of_lags);
for i_tau = 1 : number_of_lags
    tau = tau_time_step(i_tau);
    % find first and last time steps for which the pairing works at this lag
    first_time_step = max(1, -tau_time_step(i_tau) + 1);
    last_time_step = min(number_of_time_steps, number_of_time_steps - tau_time_step(i_tau));
    
    % calculate r_xy
    r_xy = 0;
    for i_time = first_time_step : last_time_step
        r_xy = r_xy + x_mean_free(i_time + tau) * y_mean_free(i_time);
    end
    r_x = sum(x_mean_free(first_time_step + tau : last_time_step + tau).^2);
    r_y = sum(y_mean_free(first_time_step : last_time_step).^2);
    r_xy = r_xy / (r_x^0.5 * r_y^0.5);
    r(i_tau) = r_xy;
end












