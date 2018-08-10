function g = gauss(range_x, mu, sigma)
% creates a Gaussian bell curve over the given range
% 
% Input
%  range_x = range of values over which the function is computed
%  mu = center of the bell curve
%  sigma = width of the bell curve
% 
% This version of the bell curve peaks at 1 over mu.
%
% See also gaussNorm.m
%
g = exp(-0.5 * (range_x-mu).^2 / sigma^2);

