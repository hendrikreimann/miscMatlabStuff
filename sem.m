function standard_error = sem(data, dim)
    if nargin < 2
        dim = 1;
    end
    N = size(data, dim);
    standard_error = nanstd(data, 1, dim)/sqrt(N);
end