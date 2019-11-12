function getH   
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    fnames = dir([siftdir '/*.mat']);
    
    load('kMeans.mat');
    
    H = [];
    
    for i=1:length(fnames) 
        
        % load file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors');
        
        if (size(descriptors,1) > 0)
            [h,~] = makeH(descriptors, kMeans);
        else
            h = zeros(1500,1);
        end
        
        H = cat(1,H,h');
        
        if (i == 1000)
            save('histograms.mat', 'histograms');
        end
    end
    
    % savve result
    save('histograms.mat', 'histograms');
end