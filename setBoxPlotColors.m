function setBoxPlotColors(axes_handle, box_plot_data, group_order, condition_list, color_list)
    boxes = findobj(gca, 'Tag', 'Box');
    box_x_positions = zeros(size(boxes));
    for i_box = 1 : length(boxes)
        set(box_plot_data(6, i_box), 'color', 'k')
        box_x_positions(i_box) = mean(boxes(i_box).XData(2:3));
    end
    [~, box_order] = sort(box_x_positions);

    box_alpha = 1;
    for i_box = 1 : length(boxes)
        group_string = group_order{i_box};
        group_labels = strsplit(group_string, ',');
        
        color = [1 1 1];
        for i_condition = 1 : length(condition_list)
            if any(ismember(group_labels, condition_list{i_condition}))
                color = color_list(i_condition, :);
            end
        end
        
        patch_handle = patch(get(boxes(box_order(i_box)), 'XData'), get(boxes(box_order(i_box)), 'YData'), color, 'FaceAlpha', box_alpha); uistack(patch_handle, 'bottom')
%         line_handle = plot(boxes(box_order(i_box)).XData(2:3), , 'YData'), 'k', 'linewidth', 15);
    end
    
end