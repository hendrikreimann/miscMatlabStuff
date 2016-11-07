% apply the specified filter for each stretch of not-NaN data that is long enough
function y = nanfiltfilt(b, a, x)
    visualize = 0;
    
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

%             % make indicator for plotting
%             gap_indicator = zeros(size(column_raw));
%             for i_gap = 1 : size(gaps, 1)
%                 gap_indicator((time_steps >= gaps(i_gap, 1)) & (time_steps <= gaps(i_gap, 2))) = 1;
%             end
%             gap_indicator(gap_indicator == 0) = NaN;
        end
        
        % filter the stretches without gaps
        filter_order = length(a) - 1;
        column_filtered_by_stretch = zeros(size(column_raw)) * NaN;
        for i_stretch = 1 : size(data_stretches_without_gaps, 1)
            data_stretch = column_raw(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2));
            if length(data_stretch) > 3*filter_order
                data_stretch_filtered = filtfilt(b, a, data_stretch);
                column_filtered_by_stretch(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2)) = data_stretch_filtered;
            end
        end
        
        

%         % fill in small holes in the data by spline
%         if numel(column_raw) - numel(find(isnan(column_raw))) > 2
%             [~, column_splined] = evalc('csaps(time, column_raw, 1, time);');
%             % filter the stretches of data without big holes
%             column_filtered_by_stretch = zeros(size(column_raw)) * NaN;
%             for i_stretch = 1 : size(data_stretches_without_gaps, 1)
%                 data_stretch = column_splined(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2));
%                 if length(data_stretch) > 3*filter_order
%                     data_stretch_filtered = filtfilt(b, a, data_stretch);
%                     column_filtered_by_stretch(data_stretches_without_gaps(i_stretch, 1) : data_stretches_without_gaps(i_stretch, 2)) = data_stretch_filtered;
%                 end
%             end
%         else
%             column_filtered_by_stretch = column_raw;
%         end

        y(:, i_column) = column_filtered_by_stretch;

        if visualize
            figure; hold on;
            plot(column_raw, 'b-', 'linewidth', 5);
            plot(column_filtered_by_stretch, 'c-', 'linewidth', 2);
            legend('raw data', 'filtered')
        end
    end









end