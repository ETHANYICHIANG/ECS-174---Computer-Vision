function raw_descriptor_matches

    close all;
    addpath('./provided_code/');
    
    %load descriptors & images
    fname = 'twoFrameData.mat';
    load(fname, 'im1', 'im2', 'descriptors1', 'descriptors2', 'positions1', 'positions2', 'scales1', 'scales2', 'orients1', 'orients2');
    
    [oninds, ~] = selectRegion_display(im1, positions1);
   
    newInd = [];
    
    for i = 1:size(oninds,1)
        
        d = dist2(descriptors1(oninds(i),:), descriptors2);
        
        %get first 2 distances and calculate ratio;
        [M,I] = min(d); %1 x 1723
        index = I(1);   
        score = M/min(d(d~=M(1)));
        
        % threshold is set to be 0.4 to have best results
        if (score < 0.4)   
            newInd = cat(1,newInd,index);
        end
    end
    
    % display on im2
    figure;
    imshow(im2);
    displaySIFTPatches(positions2(newInd,:), scales2(newInd), orients2(newInd), im2); 
end