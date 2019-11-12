function ranks = sortFrames(list, names)
    [~, index] = sort(list, 'descend');
    ranks = [];
    for i = 1:10
        n = names(index(i),:);
        ranks = cat(1,ranks,n);
    end
end