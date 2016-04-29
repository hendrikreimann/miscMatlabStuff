function axesHandles = getAllAxes(varargin)

    figure_handles = findobj('Type','figure');
    axesHandles = [];
    for i_figure = 1 : length(figure_handles)
        axes_in_figure = findobj(figure_handles(i_figure), 'Type','axes');
        axesHandles = [axesHandles; axes_in_figure];
    end
end