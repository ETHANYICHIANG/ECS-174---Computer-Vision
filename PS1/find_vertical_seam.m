function verticalSeam = find_vertical_seam(cumulativeEnergyMap)

    %vector
    verticalSeam = zeros(size(cumulativeEnergyMap,1),1);
    
    row = cumulativeEnergyMap(size(cumulativeEnergyMap,1),:);
    x = find(row == min(row));
    
    %set to first min if more than one
    x = x(1);
    
    %local min
    %cur_min = x(1);
    
    verticalSeam(size(verticalSeam,1)) = x;
    
    %trace backward
    for i = size(verticalSeam,1)-1:-1:1
        
        next_row = cumulativeEnergyMap(i,:);
        
        val = next_row(x);
        col_num = x;
        
        if (x-1) > 0
            col_num = [col_num x-1];
            val = [val next_row(x-1)];
        end
        if (x+1) < size(next_row,2)
            col_num = [col_num x+1];
            val = [val next_row(x+1)];
        end
        new_min = col_num(find(val == min(val)));
        x = new_min(1);
        
        verticalSeam(i) = x;
    end
end