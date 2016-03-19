function string = zeroPrefixedIntegerString(number, numberOfCharacters)
    if mod(number, 1) == 0
        string = num2str(number);
        if length(string) > numberOfCharacters
            error('variable is too large for the specified number of characters')
        else
            while length(string) < numberOfCharacters
                string = ['0' string];
            end
        end
    else
        error('Please provide an integer number')
    end


end