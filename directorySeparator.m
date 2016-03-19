function separator = directorySeparator()

if ispc
    separator = '\';
elseif isunix
    separator = '/';
end
