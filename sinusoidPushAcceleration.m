% function calculating the acceleration profile resulting in a ramp displacement over a given time and distance

function acceleration = sinusoidPushAcceleration(currentTime, totalTime, peakAcceleration)

    relativeTime = currentTime / totalTime;
    
    acceleration = - 0.5 *  (cos(2 * pi * relativeTime)) * peakAcceleration + peakAcceleration/2;
end