function [out] = preprocess(img)
    %convert to gray
    I = im2gray(img);
    %flatten curved image
    sigma = 30;
    Iflatfield = imflatfield(I,sigma);
    %increase contrast
    Iadjust = imadjust(Iflatfield);
    
    %set as output
    out = Iadjust;
end