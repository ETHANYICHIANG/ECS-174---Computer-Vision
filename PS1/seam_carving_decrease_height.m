function seam_carving_reduce_height
    pic = imread('inputSeamCarvingMall.jpg');
    
    subplot(2,2,1);
    imshow(pic);
    title('original');
    eg = energy_img(pic);
    
    [d_pic d_eg] = decrease_height(pic, eg);
    
    for i=1:99
        [d_pic d_eg] = decrease_height(d_pic, d_eg);
    end
    
    subplot(2,2,2);
    imshow(d_pic);
    title('decreased pic');
    imwrite(d_pic,' outputReduceHeightMall.png');
    
    
     pic = imread('inputSeamCarvingPrague.jpg');
    
    subplot(2,2,3);
    imshow(pic);
    title('original');
    eg = energy_img(pic);
    
    [d_pic d_eg] = decrease_height(pic, eg);
    
    for i=1:99
        [d_pic d_eg] = decrease_height(d_pic, d_eg);
    end
    
    subplot(2,2,4);
    imshow(d_pic);
    title('decreased pic');
    imwrite(d_pic,' outputReduceHeightPrague.png');
    
    %j = imread('inputSeamCarvingMall.jpg');
    
    %jj = doTheSeamWidth(j,100);
    
    %imwrite(jj,'ouputReduceWidthMall.png');
end
