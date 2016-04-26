% class for the display of a stick figure

classdef MarkerStickFigure < handle
    properties
        currentTimeStep = 1;
        sceneFigure;
        sceneAxes;
        sceneBound;
        markerPlots;
        linkPlots;
        markerConnectionLinePlots;
        markerLabels;
        numberOfMarkers;
        numberOfConnectionLines;
        markerTrajectories;
        markerConnectionLineIndices;
        
        % graphics
        markerColors;
        linkColors;
        markerLinewidth = 2;
        linkLinewidth = 2;
        
        % flags
        showLinkCentersOfMass = false;
        showLinkMassEllipsoids = false;
        showStickFigure = true;
        showMarkers = true;
        showMarkerLabels = false;
    end 
    methods
        function this = MarkerStickFigure(markerTrajectories, markerConnectionLineIndices, markerLabels, sceneBound, axesHandle)
            this.markerTrajectories = markerTrajectories;
            this.numberOfMarkers = size(markerTrajectories, 2) / 3;
            this.numberOfConnectionLines = size(markerConnectionLineIndices, 2);
            this.markerConnectionLineIndices = markerConnectionLineIndices;
            if nargin < 3
                markerLabels = cell(1, this.numberOfMarkers);
                for i_marker = 1 : this.numberOfMarkers
                    markerLabels{i_marker} = [' ' num2str(i_marker)];
                end
            end
            if nargin < 4
                this.sceneBound = [-1 1; -1 1; -1 1];
            else
                this.sceneBound = sceneBound;
            end
            if nargin < 5
                this.sceneFigure = figure( 'Position', [500, 500, 600, 600], 'Name', 'scene' );
                this.sceneAxes = axes( 'Position', [ 0.1 0.1 0.8 0.8 ]);
            else
                this.sceneFigure = get(axesHandle, 'parent');
                this.sceneAxes = axesHandle;
            end
            
            this.markerColors = rand(this.numberOfMarkers, 3);
            this.linkColors = rand(this.numberOfConnectionLines, 3);
            
            axis equal; hold on;
            plot3([this.sceneBound(1, 1), this.sceneBound(1, 2)], [0, 0]+mean(sceneBound(2, :)), [0, 0]+mean(sceneBound(3, :)), 'color', 'k','Linewidth', 1, 'Linestyle',':');
            plot3([0, 0]+mean(sceneBound(1, :)), [this.sceneBound(2, 1), this.sceneBound(2, 2)], [0, 0]+mean(sceneBound(3, :)), 'color', 'k','Linewidth', 1, 'Linestyle',':');
            plot3([0, 0]+mean(sceneBound(1, :)), [0, 0]+mean(sceneBound(2, :)), [this.sceneBound(3, 1), this.sceneBound(3, 2)], 'color', 'k','Linewidth', 1, 'Linestyle',':');

            % set up marker connection line plots
            this.markerConnectionLinePlots = zeros(1, this.numberOfConnectionLines);
            for i_line = 1 : this.numberOfConnectionLines
                this.markerConnectionLinePlots(i_line) = plot3([0 0], [0 0], [0 0], 'k', 'linewidth', 1);
                uistack(this.markerConnectionLinePlots(i_line), 'bottom')
            end
            
            % set up labels
            for i_marker = 1 : this.numberOfMarkers
                this.markerLabels(i_marker) = text(0, 0, ['  ' markerLabels{i_marker}]); 
            end
            
            % set up marker plots
            this.markerPlots = zeros(1, this.numberOfMarkers);
            for i_marker = 1 : this.numberOfMarkers
                this.markerPlots(i_marker) = plot3(0, 0, 0, 'color', this.markerColors(i_marker, :), 'Linewidth', this.markerLinewidth, 'Marker', 'o');
            end
            
            
            % groom
            set(gca,'xlim',[this.sceneBound(1, 1), this.sceneBound(1, 2)],'ylim',[this.sceneBound(2, 1), this.sceneBound(2, 2)], 'zlim',[this.sceneBound(3, 1), this.sceneBound(3, 2)]);
            xlabel('x');
            ylabel('y');
            zlabel('z');
            
%             daspect([5 5 1])
%             axis tight
            view(-50,30)
%             camlight left
%             camlight('headlight')
            camlight(30, 30)
%             colormap cool
%             colormap autumn
            alpha(.4)
            
        end
        
        function update(this)
            
            % lines
            for i_line = 1 : length(this.markerConnectionLinePlots)
                if this.showMarkers
                    position_marker_one = this.markerTrajectories(this.currentTimeStep, (this.markerConnectionLineIndices(1, i_line)-1)*3+1 : (this.markerConnectionLineIndices(1, i_line)-1)*3+3);
                    position_marker_two = this.markerTrajectories(this.currentTimeStep, (this.markerConnectionLineIndices(2, i_line)-1)*3+1 : (this.markerConnectionLineIndices(2, i_line)-1)*3+3);
                    
                    set( ...
                         this.markerConnectionLinePlots(i_line), ...
                            'Xdata', [position_marker_one(1) position_marker_two(1)], ...
                            'Ydata', [position_marker_one(2) position_marker_two(2)], ...
                            'Zdata', [position_marker_one(3) position_marker_two(3)] ...
                       )
                else
                    set(this.markerConnectionLinePlots(i_line), 'visible', 'off');
                end
            end
            
            % labels
            for i_marker = 1 : this.numberOfMarkers
                if this.showMarkerLabels
                    position = this.markerTrajectories(this.currentTimeStep, (i_marker-1)*3+1 : (i_marker-1)*3+3);
                    set(this.markerLabels(i_marker), 'position', position, 'visible', 'on');
                else
                    set(this.markerLabels(i_marker), 'visible', 'off');
                end
            end
            
            % markers
            for i_marker = 1 : this.numberOfMarkers
                if this.showMarkers
                    position = this.markerTrajectories(this.currentTimeStep, (i_marker-1)*3+1 : (i_marker-1)*3+3);
                    set( ...
                         this.markerPlots(i_marker), ...
                            'Xdata', position(1), ...
                            'Ydata', position(2), ...
                            'Zdata', position(3) ...
                       )
                else
                    set(this.markerPlots(i_marker), 'visible', 'off');
                end
            end
            
            
        end
        function setMiscellaneousPlotColor(this, index, color)
            if index > length(this.miscellaneousPlots)
                error('index larger than number of miscellaneous plots')
            else
                this.miscellaneousPlots(index) = plot3(this.sceneAxes, [0 1], [0 1], [0 0], 'color', color, 'Linewidth', 1, 'Linestyle', '-');
                this.update();
            end
        end
        function setMarkerColor(this, marker_index, color)
            set(this.markerPlots(marker_index), 'color', color, 'MarkerFaceColor', color);
            this.update();
        end
        function setMarkerSize(this, marker_index, size)
            set(this.markerPlots(marker_index), 'MarkerSize', size);
            this.update();
        end
        function color = getMarkerColor(this, joint_index, marker_index)
            if joint_index == 0
                color = get(this.fixedMarkerPlots(marker_index), 'color');
            else
                color = get(this.markerPlots{joint_index}(marker_index), 'color');
            end
        end
        
        function setMarkerConnectionLineColor(this, index, color)
            set(this.markerConnectionLinePlots(index), 'color', color);
            this.update();
        end
        function setMarkerConnectionLineWidth(this, index, linewidth)
            set(this.markerConnectionLinePlots(index), 'linewidth', linewidth);
        
        end
    end
end