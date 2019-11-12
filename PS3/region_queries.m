function region_queries
    close all;
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    %list of query images, 3 success, 1 fail
    load('kMeans.mat');
    load('histograms.mat');
    %load('oninds.mat');
    framenames = ['/friends_0000005520.jpeg';  % painting
                   '/friends_0000006177.jpeg';  % fridge
                   '/friends_0000005744.jpeg';  % skirt
                   '/friends_0000005368.jpeg']; % tie
            
    %for each query region
    frameH = [];
    
    framefile = strcat(framenames(1,:), '.mat');
    im = dir([siftdir framefile]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');
    imname = [framesdir framenames(1,:)];
    im1 = imread(imname);
    [inds1, bounds1] = selectRegion_display(imname,positions);
    d = descriptors(inds1,:);
    [h,~] = makeH(d, kMeans);
    frameH = cat(1,frameH,h');    
    
    
    framefile = strcat(framenames(2,:), '.mat');
    im = dir([siftdir framefile]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');
    imname = [framesdir framenames(2,:)];
    im2 = imread(imname);
    [inds2, bounds2] = selectRegion_display(imname,positions);
    d = descriptors(inds2,:);
    [h,~] = makeH(d, kMeans);
    frameH = cat(1,frameH,h'); 
    
    
    framefile = strcat(framenames(3,:), '.mat');
    im = dir([siftdir framefile]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');
    imname = [framesdir framenames(3,:)];
    im3 = imread(imname);
    [inds3, bounds3] = selectRegion_display(imname,positions);
    d = descriptors(inds3,:);
    [h,~] = makeH(d, kMeans);
    frameH = cat(1,frameH,h');    
    
    framefile = strcat(framenames(4,:), '.mat');
    im = dir([siftdir framefile]);
    fname = [siftdir '/' im.name];
    load(fname, 'descriptors', 'positions');
    imname = [framesdir framenames(4,:)];
    im4 = imread(imname);
    [inds4, bounds4] = selectRegion_display(imname,positions);
    d = descriptors(inds4,:);
    [h,~] = makeH(d, kMeans);
    frameH = cat(1,frameH,h'); 
    
    close all;
        
    list1 = [];
    list2 = [];
    list3 = [];
    list4 = [];
    names1 = [];
    names2 = [];
    names3 = [];
    names4 = [];
    fnames = dir([siftdir '/*.mat']);
    
    for i=1:length(fnames) 
        %load all images  
        
        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors');
        if size(descriptors,1) == 0
            continue;
        end

        if strcmp(framenames(1,:), imname)
            continue;
        end
        if strcmp(framenames(2,:), imname)
            continue;
        end
        if strcmp(framenames(3,:), imname)
            continue;
        end
        if strcmp(framenames(4,:), imname)
            continue;
        end
        
        imname = [framesdir imname]; % add the full path
        
        %get histogram of each loaded image
        h = histograms(i,:);
        
        %compare histogram to any of the thee query images
        score1 = scoreH(frameH(1,:), h);
        score2 = scoreH(frameH(2,:), h);
        score3 = scoreH(frameH(3,:), h);
        score4 = scoreH(frameH(4,:), h);
        
        if (score1 > 0)
            list1 = cat(1,list1,score1);
            names1 = cat(1, names1, imname);
        end
        if (score2 > 0)
            list2 = cat(1,list2,score2);
            names2 = cat(1, names2, imname);
        end
        if (score3 > 0.)
            list3 = cat(1,list3,score3);
            names3 = cat(1, names3, imname);
        end        
        if (score4 > 0)
            list4 = cat(1,list4,score4);
            names4 = cat(1, names4, imname);
        end
    end
    disp(size(list2));
    
    %sort scores
    rank1 = sortFrames(list1, names1);
    rank2 = sortFrames(list2, names2);
    rank3 = sortFrames(list3, names3);
    rank4 = sortFrames(list4, names4);
    
    %display images
    figure;
    subplot(2,3,1);
    imname = [framesdir framenames(1,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds1(:,1),bounds1(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Target Region');
    for i = 1:size(rank1,1)
        n = i + 1;
        subplot(2,3,n);
        g = imread(rank1(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
    
    figure;
    subplot(2,3,1);
    imname = [framesdir framenames(2,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds2(:,1),bounds2(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Target Region');
    for i = 1:size(rank2,1)
        n = i + 1;
        subplot(2,3,n);
        g = imread(rank2(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
    
    figure;
    subplot(2,3,1);
    imname = [framesdir framenames(3,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds3(:,1),bounds3(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Target Region');
    for i = 1:size(rank3,1)
        n = i + 1;
        subplot(2,3,n);
        g = imread(rank3(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
    
    figure;
    subplot(2,3,1);
    imname = [framesdir framenames(4,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    hold on;
    h = fill(bounds4(:,1),bounds4(:,2), 'r');
    set(h, 'FaceColor','none');
    set(h, 'EdgeColor','y');
    set(h, 'LineWidth',5);
    title('Target Region');
    for i = 1:size(rank4,1)
        n = i + 1;
        subplot(2,3,n);
        g = imread(rank4(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
end