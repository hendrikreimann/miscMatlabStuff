% normalizes an angle in radian to the standard representation in the
% interval (-pi, pi]

function value = normalizeAngle(value)

while any(value <= -pi)
    value(value <= -pi) = value(value <= -pi) + 2*pi;
end
while value > pi
    value(value > pi) = value(value > pi) - 2*pi;
end
    