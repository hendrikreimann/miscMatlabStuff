function x = lineIntersection ...
( ...
    p1, ... % center of line 1
    p2, ... % center of line 2
    q1, ... % direction of line 1
    q2  ... % direction of line 2
)

lambda = (q1(2)*(p1(1)-p2(1)) - q1(1)*(p1(2)-p2(2))) / (q1(2)*q2(1) - q1(1)*q2(2));

x = p2 + lambda*q2;

% figure; axes; hold on; axis equal
% plot([r(1) r(1) + s(1)], [r(2) r(2) + s(2)], 'b');
% plot([p(1) p(1) + q(1)], [p(2) p(2) + q(2)], 'r');
% plot(x(1), x(2), 'mx')
