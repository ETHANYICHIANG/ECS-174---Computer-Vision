function  energyImg = energy_img(im)

    % This function compute the energy at each pixel using the magnitude of the x and y gradients
    
    
    gray_im = rgb2gray(im); 
    
    dx = imfilter(double(gray_im),[-1,1]);
    dy = imfilter(double(gray_im),[-1;1]);
    
    energyImg = sqrt(dx.^2 + dy.^2);

end
 

