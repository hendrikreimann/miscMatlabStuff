function h = triangleHeight(a, b, c)
% calculate the height of the triangle with sides a, b, c, over a
    
    % check if this is actually a triangle over a
    if (a >= b+c) || (b >= c+a) || (c >= a+b)
        h = 0;
    else
        s = (a + b + c)/2;
        h = 2 * sqrt(s*(s-a)*(s-b)*(s-c)) / a;
    end
    


end