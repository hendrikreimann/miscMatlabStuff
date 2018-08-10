function fileName = createFileName(date, subject_id, study_label, trial_id, qualifier)
    if isnumeric(trial_id)
        trial_id = num2str(trial_id);
    end
    fileName = [date '_' study_label '_' subject_id '_' trial_id '_' qualifier];
return
