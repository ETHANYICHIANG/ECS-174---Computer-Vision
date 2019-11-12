function [reducedColorImg,reducedEnergyImg] = decrease_height(im,energyImg)

    reducedColorImg = uint8(zeros(size(im,1)-1, size(im,2), 3));
    reducedEnergyImg = zeros(size(im,1)-1, size(im,2));
    
    cum_eg_map = cumulative_min_energy_map(energyImg, 'HORIZONTAL');
    v_seam = find_horizontal_seam(cum_eg_map);
    
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);   
    
    for i = 1:size(im,2)
        Rrow = R(:,i);
        Grow = G(:,i);
        Brow = B(:,i);
        
        Rrow(v_seam(i)) = [];       
        Grow(v_seam(i)) = [];       
        Brow(v_seam(i)) = [];
        
        new_row = cat(3, Rrow, Grow, Brow);
        reducedColorImg(:,i,:) = new_row;
        new_row = energyImg(:,i);
        new_row(v_seam(i)) = [];
        reducedEnergyImg(:,i) = new_row;
    end
end