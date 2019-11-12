clear;
close all;

im = imread('cap-daylight-daytime.jpg');

subplot(3,3,2);
imshow(im);
title("ORIGINAL - 640x640");

eg = energy_img(im);
    
[d_pic d_eg] = decrease_height(im, eg);

for i=1:49
    [d_pic d_eg] = decrease_height(d_pic, d_eg);
end

subplot(3,3,4);
imshow(d_pic);
title('height reduce 50 ');

for i=1:50
    [d_pic d_eg] = decrease_height(d_pic, d_eg);
end

subplot(3,3,5);
imshow(d_pic);
title('height reduce 100 ');

for i=1:50
    [d_pic d_eg] = decrease_width(d_pic, d_eg);
end

subplot(3,3,6);
imshow(d_pic);
title('width reduce 50');

r_pic = imresize(im, [size(d_pic,1) size(d_pic,2)]);
subplot(3,3,8);
imshow(r_pic);
title('imresize - 590x540');