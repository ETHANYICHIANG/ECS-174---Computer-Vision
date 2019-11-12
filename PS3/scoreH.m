function score = scoreH(source,test)
    score = (source*test')/(norm(source, 'fro') * norm(test, 'fro'));
end