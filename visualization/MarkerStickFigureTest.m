

% generate test data
time = 0.01 : 0.01 : 1;
marker_one_trajectory = [sin(time*2*pi)' -1*ones(size(time')) -1*ones(size(time'))];
marker_two_trajectory = [-sin(time*2*pi)' -1*ones(size(time')) 1*ones(size(time'))];
marker_three_trajectory = [-sin(time*2*pi)' 1*ones(size(time')) 1*ones(size(time'))];
marker_four_trajectory = [sin(time*2*pi)' 1*ones(size(time')) -1*ones(size(time'))];
marker_trajectories = [marker_one_trajectory marker_two_trajectory marker_three_trajectory marker_four_trajectory];

marker_connection_line_indices = [1 2 3 4; 2 3 4 1];
stickFigure = MarkerStickFigureViewer(marker_trajectories, marker_connection_line_indices);

stickFigure.showMarkerLabels = true;
stickFigure.update;

