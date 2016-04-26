function [thresholdCrossings, directions] = findThresholdCrossings(data, threshold)
    
    number_of_time_steps = length(data);
    thresholdCrossings = [];
    directions = [];
    for i_frame = 1 : length(data) - 1
        if (data(i_frame) < threshold) && (data(i_frame+1) >= threshold)
            thresholdCrossings = [thresholdCrossings; i_frame];
            directions = [directions; 1];
        elseif (data(i_frame) > threshold) && (data(i_frame+1) <= threshold)
            thresholdCrossings = [thresholdCrossings; i_frame];
            directions = [directions; -1];
        end
    end

    % deal with NaN stretches
    nanstarts = [];
    nanends = [];
    if isnan(data(1))
        nanstarts = 1;
    end
    for i_time = 1 : number_of_time_steps-1
        if ~isnan(data(i_time)) && isnan(data(i_time+1))
            nanstarts = [nanstarts; i_time+1];
        end
        if isnan(data(i_time)) && ~isnan(data(i_time+1))
            nanends = [nanends; i_time];
        end
    end    
    if isnan(data(end))
        nanends = [nanends; number_of_time_steps];
    end
    for i_nan = 1 : length(nanstarts)
        if (nanstarts(i_nan) ~= 1) && (nanends(i_nan) ~= number_of_time_steps)
            % some data coming after this NaN stretch
            if     (data(nanstarts(i_nan)-1) <  threshold) && (data(nanends(i_nan)+1) >= threshold)
                thresholdCrossings = [thresholdCrossings; floor(mean([nanstarts(i_nan) nanends(i_nan)]))];
                directions = [directions; 0];
            elseif (data(nanstarts(i_nan)-1) >= threshold) && (data(nanends(i_nan)+1) < threshold)
                thresholdCrossings = [thresholdCrossings; floor(mean([nanstarts(i_nan) nanends(i_nan)]))];
                directions = [directions; 0];
            end
        end
    end
    
    % sort the threshold crossings
    [thresholdCrossings, sort_indices] = sort(thresholdCrossings);
    directions = directions(sort_indices);
    
return



%#ok<*AGROW>