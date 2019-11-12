function [h, ind] = makeH(image,vocab)
    
    % get histogram with single image frame and the k-mean vocab

    d = dist2(image,vocab); 
    freq = zeros(size(image,1),1); 
    [~, freq] = min(d,[],2); 
    [h, ind] = histc(freq,1:1500);
    
    if (size(h,1)==1)
        x = h';
        h = x;
    end
end