% derive long-enough stretches of not-NaN data by time
function y = nanDeriveByTime(x, time)

    y = zeros(size(x));
    number_of_time_steps = size(x, 1);
    for i_column = 1 : size(x, 2)
        column_raw = x(:, i_column);

        % find the gaps
        gaps = isnan(column_raw);
        gap_start_indices = [];
        gap_end_indices = [];
        first_data_point = find(~isnan(column_raw), 1);
        if isempty(first_data_point)
            first_data_point = number_of_time_steps+1;
        end
        for i_time = first_data_point : number_of_time_steps
            if isnan(column_raw(i_time))
                % check if this is the start of a gap
                if (i_time == 1) || (~isnan(column_raw(i_time-1)))
                    gap_start_indices = [gap_start_indices; i_time]; %#ok<*AGROW>
                end
                % check if this is the end of a gap
                if (i_time == number_of_time_steps) || (~isnan(column_raw(i_time+1)))
                    gap_end_indices = [gap_end_indices; i_time];
                end

            end
        end
        
        gaps = [gap_start_indices gap_end_indices];

        % find the pieces of data without gaps
        data_stretches_without_gaps = [];
        if isempty(gaps)
            data_stretches_without_gaps = [first_data_point number_of_time_steps];
        else
            if  gaps(1, 1) > 1
                data_stretches_without_gaps = [first_data_point gaps(1, 1)-1];
            end
            for i_gap = 1 : size(gaps, 1) - 1
                % add the stretch after this big gaps to the list
                data_stretches_without_gaps = [data_stretches_without_gaps; gaps(i_gap, 2)+1 gaps(i_gap+1, 1)-1];
            end
            if ~isempty(gaps) && gaps(end, 2) < number_of_time_steps
                data_stretches_without_gaps = [data_stretches_without_gaps; gaps(end, 2)+1 number_of_time_steps];
            end
            % TODO: check if the limit cases are treated correctly

        end
        
        % process the stretches without gaps
        column_derived_by_stretch = zeros(size(column_raw)) * NaN;
        for i_stretch = 1 : size(data_stretches_without_gaps, 1)
            data_stretch = column_raw(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2));
            if length(time) > 1
                time_stretch = time(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2));
            else
                time_stretch = time;
            end
            data_stretch_derived = deriveByTime(data_stretch, time_stretch);
            column_derived_by_stretch(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2)) = data_stretch_derived;
        end
        
        y(:, i_column) = column_derived_by_stretch;
    end

    
    
end
    
    
    
    