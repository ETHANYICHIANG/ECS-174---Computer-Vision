function horizontalSeam = find_horizontal_seam(cumulativeEnergyMap)

    %vector
    horizontalSeam = zeros(1,size(cumulativeEnergyMap,2));
    
    col = cumulativeEnergyMap(:,size(cumulativeEnergyMap,2));
    x = find(col == min(col));
    
    %set to first min if more than one
    x = x(1);
    
    horizontalSeam(size(horizontalSeam,2)) = x;
    
    %trace backward
    for i = size(horizontalSeam,2)-1:-1:1
        
        next_col = cumulativeEnergyMap(:,i);
        
        val = next_col(x);
        row_num = x;
        
        if (x-1) > 0
            row_num = [row_num x-1];
            val = [val next_col(x-1)];
        end
        if (x+1) < size(next_col,2)
            row_num = [row_num x+1];
            val = [val next_col(x+1)];
        end
        new_min = row_num(find(val== min(val)));
        x = new_min(1);
        
        horizontalSeam(i) = x;
    end

end