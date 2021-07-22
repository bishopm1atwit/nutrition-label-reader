function [output] = postprocess(cellArrayText)
    %init output
    output = '';
    %extract cell containing calories
    index = find(contains(cellArrayText,'Cal'));
    calories = cellArrayText{index};
    
    %split cell containing calories into array by line
    C = splitlines(calories);
    
    %find element within new array that contains calories
    index = find(contains(C,'Cal'));
    calories = C{index};
    
    %extract numbers
    nums = regexp(calories,'[0-9]','Match');
    nums = strjoin(nums)
    nums = strrep(nums,' ','');
   
    calories = 'Calories';
    
    %add string with numbers to title string 'Calories' with space between
    output = strcat(output, calories);
    output = strcat(output, {' '}, nums);
    
    %repeat above steps for all nutrients
end