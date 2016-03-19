% normalizes an angle in radian to the standard representation in the
% interval (-pi, pi]

function value = normalizeAngle(value)

while any(any(value <= -pi))
    value(value <= -pi) = value(value <= -pi) + 2*pi;
end
while any(any(value > pi))
    value(value > pi) = value(value > pi) - 2*pi;
end
    