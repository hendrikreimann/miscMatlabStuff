% test the normalized cross covariance

time_step = 0.001;
T = 30;
time = time_step : time_step : T;
alpha_x = 1;
alpha_y = 1;
sigma = 0;
lag = 0.1;
x = alpha_x * sin(2*pi*time);
y = alpha_y * sin(2*pi*(time + lag)) + sigma*randn(size(time));

[r, tau] = normalizedCrossCovariance(x, y, 1/time_step, -.5, .5);

figure; axes; hold on
plot(time, x, 'r', 'linewidth', 2);
plot(time, y, 'g', 'linewidth', 2);

figure; axes; hold on
plot(tau, r, 'b', 'linewidth', 2);

