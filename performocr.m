function [output] = performocr(processedImg)

    %ocr for only calories?
    %ocrtxt = ocr(processedImg, 'CharacterSet','Calories0123456789','TextLayout','Block');
    
    %ocr for everything
    ocrtxt = ocr(processedImg);
    for i= 1 :numel(ocrtxt)
        fprintf('%s\r\n',ocrtxt(i).Text);
        cellArrayText{i} = sprintf('%s\r\n',ocrtxt(i).Text);
    end
    output = cellArrayText;
        
    %calories function gets calories and shows figure with bounding box
    calories(ocrtxt, processedImg);
end