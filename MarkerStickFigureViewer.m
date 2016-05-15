function stickFigure = MarkerStickFigureViewer(markerTrajectories, markerConnectionLineIndices, markerLabels, sceneBound)
    
    %% create the stick figure
    if nargin < 3
        markerLabels = cell(1, size(markerTrajectories, 2)/3);
        for i_marker = 1 : size(markerTrajectories, 2)/3
            markerLabels{i_marker} = num2str(i_marker);
        end
    else
        this.markerLabels = markerLabels;
    end
    if nargin < 4
        sceneBound = 1*[-1 1; -1 1; -1 1];
    end
    
    stickFigure = MarkerStickFigure(markerTrajectories, markerConnectionLineIndices, markerLabels, sceneBound);
    stickFigure.update();
    view(30, 30)
    
    
    number_of_time_steps = size(markerTrajectories, 1);
	number_of_markers = stickFigure.numberOfMarkers;
    
    %% create the control figure
    control_figure = figure('Position', [100, 650, 500, 100]);    
    current_time_step_slider = uicontrol(control_figure, 'Style', 'Slider',...
                                                   'Callback', @timeStepSliderChanged,...
                                                   'Position', [10, 10, 450, 10]);
    set( ...
         current_time_step_slider, ...
         'Value', 1, ...
         'Min', 1, ...
         'Max', number_of_time_steps, ...
         'sliderStep', [1*(number_of_time_steps-1)^(-1) number_of_time_steps^(-1)*10] ...
         );
    current_time_step_label = uicontrol(control_figure, 'Style', 'text', 'Position', [460, 5, 40, 15]);
    
    % video stuff
                          uicontrol(control_figure, 'Style', 'text', 'Position', [10, 70, 40, 18], 'string', 'Start:');
    video_start_box     = uicontrol(control_figure, 'Style', 'edit', 'Position', [50, 70, 40, 20], 'string', '1');
                          uicontrol(control_figure, 'Style', 'text', 'Position', [10, 50, 40, 18], 'string', 'End:');
    video_end_box       = uicontrol(control_figure, 'Style', 'edit', 'Position', [50, 50, 40, 20], 'string', num2str(number_of_time_steps));
                          uicontrol(control_figure, 'Style', 'text', 'Position', [10, 30, 40, 18], 'string', 'Interval:');
    video_interval_box  = uicontrol(control_figure, 'Style', 'edit', 'Position', [50, 30, 40, 20], 'string', '5');
    record_video_checkbox = uicontrol(control_figure, 'Style', 'checkbox', 'Position', [92, 70, 18, 18]);
    uicontrol(control_figure, 'Style', 'text', 'Position', [112, 70, 40, 18], 'string', 'record');
    uicontrol(control_figure, 'Style', 'pushbutton', 'Position', [90, 30, 80, 40], 'string', 'Play Video', 'Callback', @playVideo);
                                               
    uicontrol(control_figure, 'Style', 'pushbutton', 'Position', [420, 30, 80, 40], 'string', 'Quit', 'Callback', @quit);
        

    showTimeStep(1);

%% set the time step for display
function showTimeStep(index, hObject)
    
    if nargin < 2
        hObject = 0;
    end
    
    stickFigure.currentTimeStep = index;
    stickFigure.update();
    
    % update label
    set(current_time_step_label, 'String', num2str(index));
    
    % update slider
    if hObject ~= current_time_step_slider
        set(current_time_step_slider, 'Value', index)
    end
    
    
    drawnow;
end




%% deal with time step slider change
function timeStepSliderChanged(hObject, eventdata) %#ok<INUSD>
    % get data
    current_time_step = floor(get(current_time_step_slider(1), 'Value'));
    
    % update figure
    showTimeStep(current_time_step, hObject);
end

%% play video
function playVideo(hObject, eventdata) %#ok<INUSD>
    % get data
    start_time_step = str2double(get(video_start_box, 'string'));
    end_time_step = str2double(get(video_end_box, 'string'));
    interval = str2double(get(video_interval_box, 'string'));
    frames = start_time_step : interval : end_time_step;
    number_of_frames = length(frames);
    record_video = get(record_video_checkbox, 'value');
    
    % create recording container
    if record_video
        video_figure = stickFigure.sceneFigure;
        window_size = get(video_figure, 'Position');
        window_size(1:2) = [0 0];
        movie_container = moviein(number_of_frames, video_figure, window_size);
        set(video_figure, 'NextPlot', 'replacechildren');
    end
    
    % play movie
    for i_frame = 1 : number_of_frames
        showTimeStep(frames(i_frame));
        if record_video
            movie_container(:, i_frame) = getframe(video_figure, window_size); 
        end
    end
    
    % save
    if record_video
        mpgwrite(movie_container, jet, 'movie.mpg');
    end
    
    % TODO: display the time 
end

%% quit
function quit(hObject, eventdata) %#ok<INUSD>
    close all
end

end