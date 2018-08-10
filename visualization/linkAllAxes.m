function axesHandles = linkAllAxes(varargin)

    if nargin < 1
        varargin = {'xlim', 'ylim'};
    end
    figure_handles = findobj('Type','figure');
    axesHandles = [];
    for i_figure = 1 : length(figure_handles)
        axes_in_figure = findobj(figure_handles(i_figure), 'Type','axes');
        axesHandles = [axesHandles; axes_in_figure];
    end
    linkprop(axesHandles, varargin);

%     if nargin < 1
%         option = 'xy';
%     end
%     figure_handles = findobj('Type','figure');
%     axesHandles = [];
%     for i_figure = 1 : length(figure_handles)
%         axes_in_figure = findobj(figure_handles(i_figure), 'Type','axes');
%         axesHandles = [axesHandles; axes_in_figure];
%     end
%     linkaxes(axesHandles, option);
end