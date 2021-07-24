function [output] = postprocess(cellArrayText)

    %make all lowercase
    cellArrayText = lower(cellArrayText);
    
    temp = calories(cellArrayText);
    output = sprintf('%s \n', temp);
   
    temp = totalfat(cellArrayText);
    output = sprintf('%s%s \n', output, temp);
    
    temp = cholesterol(cellArrayText);
    output = sprintf('%s%s \n', output, temp);
    
    temp = sodium(cellArrayText);
    output = sprintf('%s%s \n', output, temp);
    
    temp = carb(cellArrayText);
    output = sprintf('%s%s \n', output, temp);
    
    temp = protein(cellArrayText);
    output = sprintf('%s%s \n', output, temp);
    
    %repeat above steps for all nutrients
end