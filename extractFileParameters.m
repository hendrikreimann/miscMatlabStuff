function [date, subject_id, study_label, trial_id, qualifier] = extractFileParameters(fileName)

% function [subject_number, study_label, label, subject_type, day, foot, first_index, last_index] = extractFileParameters(fileName)
    underscores = find(fileName == '_' | fileName == '-'); % Location of underscores
    date = fileName(1:underscores(1)-1); % date
    study_label = fileName(underscores(1)+1:underscores(2)-1); % study
    subject_id= fileName(underscores(2)+1:underscores(3)-1); % initials
    if numel(underscores) > 3
        trial_id = fileName(underscores(3)+1:underscores(4)-1); % number
        qualifier = fileName(underscores(4)+1:length(fileName)-4); % data type
    elseif numel(underscores) == 3
        trial_id = fileName(underscores(3)+1:length(fileName)-4); % number
        qualifier = ''; % data type
    end
return
