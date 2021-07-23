function [output] = postprocess(cellArrayText)
    %init output
    output = '';
    cellArrayText = lower(cellArrayText);
    
    
    
    %extract cell containing calories
    index = find(contains(cellArrayText, 'cal'));
    if size(index) > 0
        calories = cellArrayText{index};

        %split cell containing calories into array by line
        C = splitlines(calories);

        %find element within new array that contains calories
        index = find(contains(C, 'cal'));
        if size(index) > 0
            calories = C{index};

            %extract numbers
            nums = regexp(calories,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

            calories = 'Calories';

            %add string with numbers to title string 'Calories' with space between
            output = strcat(output, calories); 
            output = sprintf('%s %s \n', output, nums);
        else
            output = 'Calories not found';
        end
    else %Cal was not found in image
        output = 'Calories not found';
    end
    
 
   
    %extract cell containing total fat
    index = find(contains(cellArrayText, 'tal f'));
    if size(index) > 0
        calories = cellArrayText{index};

        %split cell containing calories into array by line
        C = splitlines(calories);

        %find element within new array that contains calories
        index = find(contains(C, 'tal f'));
        if size(index) > 0
            totalfat = C{index};

            %extract numbers - %TODO need to omit the last number found
            nums = regexp(totalfat,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

            totalfat = 'Total Fat';

            %add string with numbers to title string 'Calories' with space between
            output = sprintf('%s %s', output, totalfat);
            output = sprintf('%s %s%s \n', output, nums, 'g');
        else
            output = sprintf('%s%s', output, 'Total Fat not found');
        end
    else %total fat was not found in image
        output = sprintf('%s%s', output, 'Total Fat not found');
    end
    
    %repeat above steps for all nutrients
end