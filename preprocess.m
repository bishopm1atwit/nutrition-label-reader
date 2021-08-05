function [out] = preprocess(img)
    [x,y, numberOfColorChannels] = size(img);
    %convert to gray
    I = im2gray(img);
    
    %flatten curved image
    sigma = 30;
    Iflatfield = imflatfield(I,sigma);
    
    %increase contrast
    Iadjust = imadjust(Iflatfield);
    
    % morphological top-hat filtering
    if x > y
        se = x/10;
    else
        se = y/10;
    end
    Icorrected = imtophat(Iadjust,strel('disk',fix(se)));
    
    %binarize the image
    BW1 = imbinarize(Icorrected);
    
    %binary to grayscale
    uint8Image = uint8(255 * BW1);
    
    %set as output
    out = uint8Image;
end