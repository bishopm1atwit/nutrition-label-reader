function calories(ocrtext, I)
    
    regularExpr = 'Calories \d\d\d\d\d';
    bboxes = locateText(ocrtext,regularExpr,'UseRegexp',true);
    for i = 1:4
        if isempty(bboxes)
            regularExpr = regularExpr(1:end-2);
            bboxes = locateText(ocrtext,regularExpr,'UseRegexp',true);
        else
            break
        end
    end

    digits = regexp(ocrtext.Text,regularExpr,'match');

    % draw boxes around the digits
    Idigits = insertObjectAnnotation(I,'rectangle',bboxes,digits);

    figure; 
    imshow(Idigits);
end