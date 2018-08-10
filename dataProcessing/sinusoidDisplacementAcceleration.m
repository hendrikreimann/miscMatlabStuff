% function calculating the acceleration profile resulting in a ramp displacement over a given time and distance

function acceleration = sinusoidDisplacementAcceleration(currentTime, totalTime, totalDistance)

    relativeTime = currentTime / totalTime;
    
    acceleration = 2 * pi^2 / totalTime^2 * (cos(2 * pi * relativeTime)) * totalDistance;
end