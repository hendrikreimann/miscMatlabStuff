function [s1, s2] = lineDistance_points ...
( ...
    A_1, ... % start of line segment 1
    B_1, ... % end of line segment 1
    A_2, ... % start of line segment 2
    B_2 ... % end of line segment 2
)

% calls lineDistance 


center_1 = A_1 + 0.5*(B_1-A_1);
if A_1 == B_1
    direction_1 = zeros(3, 1);
else
    direction_1 = (B_1-A_1) * 1 / norm(B_1-A_1);
end

center_2 = A_2 + 0.5*(B_2-A_2);
if A_2 == B_2
    direction_2 = zeros(3, 1);
else
    direction_2 = (B_2-A_2) * 1 / norm(B_2-A_2);
end

[s1, s2] = lineDistance ...
( ...
    center_1, ... % center of line segment 1
    center_2, ... % center of line segment 2
    direction_1, ... % direction of line segment 1
    direction_2 ... % direction of line segment 2
);