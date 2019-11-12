function C = getCorrespondences(Im,pt_num)
    
    close all;

    imshow(Im);
    
    % collect 4 correspondence pts
    [x,y] = ginput(pt_num);
    
    C = cat(1,x',y');
end