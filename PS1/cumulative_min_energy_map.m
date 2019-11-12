function cumulativeEnergyMap = cumulative_min_energy_map(energyImg,seamDirection)

    cumulativeEnergyMap = zeros(size(energyImg));
    
    % check seam direction
    if(strcmp(seamDirection, 'VERTICAL'))
        % copy first row
        cumulativeEnergyMap(1,:) = energyImg(1,:);
        
        for i = 2:size(energyImg,1) 
            for j = 1:size(energyImg,2)
                x = cumulativeEnergyMap(i-1,j);
                if (j-1) > 0
                    x = [x,cumulativeEnergyMap(i-1,j-1)];
                end
                if (j+1) < size(energyImg,2)
                    x = [x,cumulativeEnergyMap(i-1,j+1)];
                end
                cumulativeEnergyMap(i,j) = energyImg(i,j) + min(x);
            end
        end
    else
        % ‘HORIZONTAL’ 
        cumulativeEnergyMap(:,1) = energyImg(:,1);
        for i = 2:size(energyImg,2)
            for j = 1:size(energyImg,1)
                x = cumulativeEnergyMap(j,i-1);
                if (j-1) > 0
                    x = [x cumulativeEnergyMap(j-1,i-1)];
                end
                if (j+1) < size(energyImg,1)
                    x = [x cumulativeEnergyMap(j+1,i-1)];
                end
                cumulativeEnergyMap(j,i) = energyImg(j,i) + min(x);
            end
        end 
    end
end