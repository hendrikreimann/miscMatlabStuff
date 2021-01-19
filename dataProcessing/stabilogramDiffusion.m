% calculate the stabilogram diffusion function for a posturogram (CoP
% trajectory)

function [sdf, delta_t] = stabilogramDiffusion(cop, timeStep, maxInterval)
    % transform maxInterval to timeSteps
    max_interval_steps = maxInterval / timeStep;
    
    number_of_time_steps = size(cop, 2);
    sdf = zeros(1, max_interval_steps-1);
    
%     progressBar = waitbar(0, 'Calculating Stabilogram Diffusion', 'Position', [ 1200, 1600, 400, 60 ]);
    for i_interval = 1 : max_interval_steps-1
        cop_shifted = [cop(1+i_interval : end) zeros(1, i_interval)];
        difference = cop(1 : number_of_time_steps - i_interval) - cop_shifted(1 : number_of_time_steps - i_interval);
        sdf(i_interval) = mean(difference.^2);
        
        
%         waitbar(i_interval / (number_of_time_steps - max_interval_steps), progressBar, 'Trying not to fall down...')
        
    end

    delta_t = (timeStep : timeStep : maxInterval-timeStep);
end