function H = computeH(t1, t2)
        
    A = zeros(2*size(t1,2), 9);
    
    
    % (x,y) = t1; (x',y') = t2
    % [ x1 y1 1 0 0 0 -x'1x1 -x'1y1 -x'1
    %   0  0  0 x1 y1 1 -y'1x1 -y'1y1 -y'1 ]
    
    for i = (1:size(t1,2))
        
        x = t1(1,i);
        y = t1(2,i);
        x_p = t2(1,i);
        y_p = t2(2,i);
        
        A((2 * i - 1):(2*i),:) = [ x y 1 0 0 0 -x_p*x -x_p*y -x_p;
                                     0 0 0 x y 1 -y_p*x -y_p*y -y_p]; 
    end

    % get eigenvalue
    [h, ~] = eigs(A'*A, 1, 'smallestabs');
    H = reshape(h,[3,3])';
        
end