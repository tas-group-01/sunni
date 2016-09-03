function Gray_image = rgb_to_gray(Image)
% RGB_TO_GRAY  converts image to gray scale image.
%   Gray_image = RGB_TO_GRAY(Image)

if(size(Image,3) == 1)
    % returns gray image if image is already gray
    Gray_image = Image;
else if (size(Image,3) ~= 3)
    error('Wrong Dimensions!')  
else
    % division into three channels
    R = Image(:,:,1);
    G = Image(:,:,2);
    B = Image(:,:,3);
    % calculation
    Gray_image = 0.299*R + 0.587*G + 0.114*B;
end
    
end