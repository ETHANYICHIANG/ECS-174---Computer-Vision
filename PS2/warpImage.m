function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)

    close all;
    
    inputIm = imread(inputIm);
    refIm = imread(refIm);
    
    figure;
    imshow(uint8(inputIm));
    title("inputIm");
    figure;
    imshow(uint8(refIm));
    title("refIm");
    
    corners = [1 1; size(inputIm,1) 1 ; 1 size(inputIm,2); size(inputIm,1) size(inputIm,2)];
    
    % transform corners
    T = [corners'; ones(1,size(corners,1))];
    T2 = H*T;
    for i = 1:size(T2,2)
        T2(:,i) = T2(:,i)/T2(3,i);
    end
    
    % clear w
    T2(3,:) = [];
    
    T3 = [T2'; 1 1; size(refIm,1) 1 ; 1 size(refIm,2); size(refIm,1) size(refIm,2)];
    
    % bounding Box
    [~,xmax] = max(T3(:,1)); %max x
    box = T3(xmax,1);
    [~,xmin] = min(T3(:,1)); %min x
    box = [box T3(xmin,1)];
    [~,ymax] = max(T3(:,2)); %max y
    box = [box T3(ymax,2)];
    [~,ymin] = min(T3(:,2)); %min y
    box = [box T3(ymin,2)];
    box = round(box(:));
    
    b = [box(3)-box(4) box(1)-box(2)];
    
    % inverse warp
    [x,y] = meshgrid(box(2):(box(1)-1),box(4):(box(3)-1));
    bound = [x(:) y(:)];
    
    t1 = [bound'; ones(1,size(bound,1))];
    t2 = H\t1;
    for i = 1:size(t2,2)
        t2(:,i) = t2(:,i)/t2(3,i);
    end
    t2(3,:) = [];
    t3 = t2';
    
    
    interR = interp2(double(inputIm(:,:,1)),t3(:,1), t3(:,2));
    interG = interp2(double(inputIm(:,:,2)),t3(:,1), t3(:,2));
    interB = interp2(double(inputIm(:,:,3)),t3(:,1), t3(:,2));
    
    R = reshape(interR,b(1),b(2));
    G = reshape(interG,b(1),b(2));
    B = reshape(interB,b(1),b(2));
    newIm = cat(3,R,G,B);
    
    %disp(size(newIm));
    
    warpIm = newIm;
    
    figure;
    imshow(uint8(warpIm));
    title("warped image");
    
    
    
    % mosaic
    
    mWidth = max([size(warpIm,2);size(refIm,2)]);
    mHeight = max([size(warpIm,1);size(refIm,1)]);
    
    mergeIm = zeros(mHeight,mWidth,3);
    
    % place refIm
    
    
    for i = 1:size(refIm,1) 
        for j = 1:size(refIm,2)
            mergeIm(i,j,:) = refIm(i,j,:); 
        end
    end
    
    % place warpIm
    
    for i = 1:size(warpIm,1) 
        for j = 1:size(warpIm,2)
            if (warpIm(i,j,1)>0 || warpIm(i,j,2)>0 || warpIm(i,j,3)>0)
                mergeIm(i,j,:) = warpIm(i,j,:);
            end
        end
    end
    
    
    figure;
    imshow(uint8(mergeIm));
    title("mosaic");
    
    %mergeIm = refIm;  
end