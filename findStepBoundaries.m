function [step_initiation_points, step_termination_points] = findStepBoundaries(positionData, velocityData, accelerationData, peaks, positionThreshold, velocityThreshold, accelerationThreshold)
    step_initiation_points = []; step_termination_points = [];
    % check start of data
    if positionData(1) > positionThreshold
        % go forward in time until standstill
        i_time = 1;
        while positionData(i_time) > positionThreshold
            i_time = i_time + 1;
        end
        while velocityData(i_time) < -velocityThreshold
            i_time = i_time + 1;
        end
        while accelerationData(i_time) > accelerationThreshold
            i_time = i_time + 1;
        end
        step_termination_points = [step_termination_points; i_time];
    end
    
    for i_peak = 1 : length(peaks)
        % go backward in time until standstill
        i_time = peaks(i_peak);
        while positionData(i_time) > positionThreshold || isnan(positionData(i_time))
            i_time = i_time - 1;
        end
        while velocityData(i_time) > velocityThreshold && i_time > 0
            i_time = i_time - 1;
        end
        while accelerationData(i_time) > accelerationThreshold && i_time > 0
            i_time = i_time - 1;
        end
        step_initiation_points = [step_initiation_points; i_time];
        
        % go forward in time until standstill
        i_time = peaks(i_peak);
        while positionData(i_time) > positionThreshold && i_time < length(positionData)
            i_time = i_time + 1;
        end
        while velocityData(i_time) < -velocityThreshold && i_time < length(positionData)
            i_time = i_time + 1;
        end
        while accelerationData(i_time) > accelerationThreshold && i_time < length(positionData)
            i_time = i_time + 1;
        end
        step_termination_points = [step_termination_points; i_time];
    end

    if positionData(end) > positionThreshold
        % go backward in time until standstill
        i_time = length(positionData);
        while positionData(i_time) > positionThreshold
            i_time = i_time - 1;
        end
        while velocityData(i_time) > velocityThreshold
            i_time = i_time - 1;
        end
        while accelerationData(i_time) > accelerationThreshold
            i_time = i_time - 1;
        end
        step_initiation_points = [step_initiation_points; i_time];
    end














end

 %#ok<*AGROW>    
    