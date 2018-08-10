function g = gaussNorm(range_x, mu, sigma)
% creates a Gaussian bell curve over the given range
% 
% Input
%  range_x = range of values over which the function is computed
%  mu = center of the bell curve
%  sigma = width of the bell curve
% 
% This version of the bell curve is normed to have integral 1 over range_x. Increasing sigma will decrease its maximum
% value at mu.
%
% See also gauss.m
%
if sigma == 0
  g = range_x == mu;
else
  g = exp(-0.5 * (range_x-mu).^2 / sigma^2);
  if any(g)
    g = g / sum(g);
  end
end

