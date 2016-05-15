% norm a vector

function normedVector = normVector(vector)
    normedVector = vector * norm(vector)^(-1);
end

