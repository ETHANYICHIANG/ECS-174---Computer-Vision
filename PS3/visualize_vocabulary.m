function visualize_vocabulary

    close all;
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    fnames = dir([siftdir '/*.mat']);

    
    N = 150;  % # of sample per frame
    % descriptor, position, scales, orients, frame name
    VD = []; 
    VP = [];
    VS = [];
    VO = [];
    VF = [];

    for i=1:length(fnames)
        
        % get sample from every 20 frames
        if mod(i,20)
            continue;
        end
        
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        desNum = size(descriptors,1);
        
        if desNum == 0
            continue;
        end
        
        % get N random sample descriptors and put into SIFT space       
        randinds = randperm(desNum);
        VD = cat(1,VD, descriptors(randinds(1:min([N,desNum])),:));
        VP = cat(1,VP, positions(randinds(1:min([N,desNum])),:));
        VS = cat(1,VS, scales(randinds(1:min([N,desNum]))));
        VO = cat(1,VO, orients(randinds(1:min([N,desNum]))));
        
        
        for j = 1:N
            VF = cat(1,VF,imname);
        end
        
    end
    
    [membership,means,rms] = kmeansML(1500,VD');
    VMember = membership;
    VMeans = means;
    
    count = zeros(size(VMeans,2),1);
    
    for i=1:length(VMember)
        term = VMember(i);
        count(term) = count(term)+1;
    end
    
    [max1,index1] = max(count);
    max2 = 0;
    index2 = 0;
    if (length(index1) >= 2)
        index2 = index1(2);
        max2 = max1(2);
    end
    if (length(index1) < 2)
        [max2,index2] = max(count(count~=max1));
    end    
    
    patch1 = find(VMember==index1);
    p1_display = [];
    patch2 = find(VMember==index2);
    p2_display = [];
    
    word1 = VMeans(:,index1)';
    word2 = VMeans(:,index2)';
    
    for i = 1:length(patch1)
        distance = dist2(word1, VD(patch1(i),:));
        d = distance(1);
        v = [d patch1(i)];
        p1_display = cat(1,p1_display, v);
    end
    for i = 1:length(patch2)
        distance = dist2(word2, VD(patch2(i),:));
        d = distance(1);
        v = [d patch2(i)];
        p2_display = cat(1,p2_display, v);
    end
    
    p1_display = sort(p1_display);
    p2_display = sort(p2_display);
    
    % display patches
    figure;
    for i = 1:25
        ind = p1_display(i,2);
        imname = [framesdir '/' VF(ind,:)]; 
        im = imread(imname);
        grayim = rgb2gray(im);
        patch = getPatchFromSIFTParameters(VP(ind,:), VS(ind), VO(ind),grayim);
        subplot(5,5,i);
        imshow(patch);
    end
    figure;
    for i = 1:25
        ind = p2_display(i,2);
        imname = [framesdir '/' VF(ind,:)]; 
        im = imread(imname);
        grayim = rgb2gray(im);
        patch = getPatchFromSIFTParameters(VP(ind,:), VS(ind), VO(ind),grayim);
        subplot(5,5,i);
        imshow(patch);
    end
    
    % save to kMeans.mat (kx128)
    kMeans = VMeans';
    save('kMeans.mat', 'kMeans');
end