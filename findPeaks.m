function peaks = findPeaks(data, thresholdCrossings)
    peaks = [];

    % find pairs of threshold crossings that go up and down
    for i_crossing = 1 : length(thresholdCrossings)-1
        if (data(thresholdCrossings(i_crossing)) < data(thresholdCrossings(i_crossing)+1)) %&& (data(thresholdCrossings(i_crossing+1)) > data(thresholdCrossings(i_crossing+1)+1))
            % between these two threshold crossings lies a step
            [~, peak_relative] = max(data(thresholdCrossings(i_crossing) : thresholdCrossings(i_crossing+1)));
            peaks = [peaks; thresholdCrossings(i_crossing) + peak_relative - 1]; %#ok<AGROW>
        end
        
        % deal with NaN stretches
        if isnan(data(thresholdCrossings(i_crossing)))
            % find borders of the NaN-stretch
            i_time = thresholdCrossings(i_crossing);
            while isnan(data(i_time))
                i_time = i_time - 1;
            end
            nan_stretch_start = i_time;
            i_time = thresholdCrossings(i_crossing);
            while isnan(data(i_time))
                i_time = i_time + 1;
            end
            nan_stretch_end = i_time;
            
            % check for a step after this NaN-stretch
            if data(nan_stretch_start) < data(nan_stretch_end) %&& (next_nan_stretch_start) > data(next_nan_stretch_end)
                % between these two threshold crossings lies a step
                [~, peak_relative] = max(data(thresholdCrossings(i_crossing) : thresholdCrossings(i_crossing+1)));
                peaks = [peaks; thresholdCrossings(i_crossing) + peak_relative - 1]; %#ok<AGROW>
            end
            
        end        
    end    













return
