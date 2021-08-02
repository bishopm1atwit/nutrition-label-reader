function [output] = performocr(processedImg)
    
    %ocr for everything
    ocrtxt = ocr(processedImg);
    for i= 1 :numel(ocrtxt)
        fprintf('%s\r\n',ocrtxt(i).Text);
        cellArrayText{i} = sprintf('%s\r\n',ocrtxt(i).Text);
    end
    output = cellArrayText;
        
end