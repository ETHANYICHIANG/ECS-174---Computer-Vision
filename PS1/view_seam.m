function m = view_seam(im,seam,seamDirection)

    m = im;
    if strcmp(seamDirection, 'VERTICAL')
        for i = 1:size(im,1)
            m(i,seam(i),:) = [255,0,0];
        end
    else
        for i = 1:size(im,2)
           m(seam(i),i,:) = [255,0,0];     
        end
    end

end