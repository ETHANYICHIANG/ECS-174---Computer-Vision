function [reducedColorImg,reducedEnergyImg] = decrease_width(im,energyImg)

    reducedColorImg = uint8(zeros(size(im,1), size(im,2)-1, 3));
    reducedEnergyImg = zeros(size(im,1), size(im,2)-1);
    
    cum_eg_map = cumulative_min_energy_map(energyImg, 'VERTICAL');
    v_seam = find_vertical_seam(cum_eg_map);
    
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);   
    
    for i = 1:size(im,1)
        %fprintf(i);
        Rrow = R(i,:);
        Grow = G(i,:);
        Brow = B(i,:);
        
        Rrow(v_seam(i)) = [];       
        Grow(v_seam(i)) = [];       
        Brow(v_seam(i)) = [];
        
        new_row = cat(3, Rrow, Grow, Brow);
        reducedColorImg(i,:,:) = new_row;
        new_row = energyImg(i,:);
        new_row(v_seam(i)) = [];
        reducedEnergyImg(i,:) = new_row;
    end

end