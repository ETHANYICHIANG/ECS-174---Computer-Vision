function full_frame_queries
    %establish paths
    close all;
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    %load kMeans from part 2
    load('kMeans.mat');
    load('histograms.mat');
    frameName = ['/friends_0000000070.jpeg';
                  '/friends_0000003655.jpeg';
                  '/friends_0000006663.jpeg'];
    
    frameH = [];
    
    for i = 1:size(frameName,1)
        framefile = strcat(frameName(i,:), '.mat');
        im = dir([siftdir framefile]);
        fname = [siftdir '/' im.name];
        load(fname, 'imname', 'descriptors');
        imname = [framesdir frameName(i,:)];
        [h,~] = makeH(descriptors, kMeans);
        frameH = cat(1,frameH,h');
    end
    %queryH: 3*1500
    
    list1 = [];
    list2 = [];
    list3 = [];
    names1 = [];
    names2 = [];
    names3 = [];
    
    fnames = dir([siftdir '/*.mat']);
    
    for i=1:length(fnames) 
        %load all images  
        
        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors');
        if size(descriptors,1) == 0
            continue;
        end
        
        if strcmp(frameName(1,:), imname)
            continue;
        end
        if strcmp(frameName(2,:), imname)
            continue;
        end
        if strcmp(frameName(3,:), imname)
            continue;
        end
        
        imname = [framesdir imname]; 
        
        % get histogram from histogram.mat
        h = histograms(i,:);
        
        %compare histogram to any of the thee query images
        score1 = scoreH(frameH(1,:), h);
        %if their score is above a certain threshold, put their name in a list
        if (score1 > 0.3)
            list1 = cat(1,list1,score1);
            names1 = cat(1, names1, imname);
        end
        score2 = scoreH(frameH(2,:), h);
        if (score2 > 0.3)
            list2 = cat(1,list2,score2);
            names2 = cat(1, names2, imname);
        end
        score3 = scoreH(frameH(3,:), h);
        if (score3 > 0.3)
            list3 = cat(1,list3,score3);
            names3 = cat(1, names3, imname);
        end
    end
    
    % sort to get top 4
    rank1 = sortFrames(list1, names1);
    rank2 = sortFrames(list2, names2);
    rank3 = sortFrames(list3, names3);
    
    %display top 5 results for each query image
    figure;
    subplot(2,3,1);
    imname = [framesdir frameName(1,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    title('Target Image');
    for i = 1:size(rank1,1)
        subplot(2,3,i+1);
        g = imread(rank1(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
    
    figure;
    subplot(2,3,1);
    imname = [framesdir frameName(2,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    title('Target Image');
    for i = 1:size(rank2,1)
        subplot(2,3,i+1);
        g = imread(rank2(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
    
    figure;
    subplot(2,3,1);
    imname = [framesdir frameName(3,:)]; % add the full path
    im = imread(imname);
    imshow(im);
    title('Target Image');
    for i = 1:size(rank3,1)
        subplot(2,3,i+1);
        g = imread(rank3(i,:));
        imshow(g);
        t = ['Rank ' int2str(i)];
        title(t);
    end
end
