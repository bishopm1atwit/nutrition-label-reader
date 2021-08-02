function [output] = calories(cellArrayText)
    %init output
    output = '';
    
    %carb matches
    matches = ["cal"; "ories"];

    %extract cell containing calories
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        calText = cellArrayText{index};

        %split cell containing calories into array by line
        C = splitlines(calText);

        %find element within new array that contains calories
        index = find(contains(C, matches));
        if size(index) > 0
            calText = C{index};

            %extract numbers
            nums = regexp(calText,'[0-9]','Match');
            if size(nums) > 0
                nums = strjoin(nums);
                nums = strrep(nums,' ','');

                calText = 'Calories';

                if(strlength(nums) ~= 0)
                    %add string with numbers to title string 'Calories' with space between
                    output = strcat(output, calText); 
                    output = sprintf('%s %s \n', output, nums);
                else
                   output = sprintf('%s \n', 'Calories not found');
                end
            else
                output = sprintf('%s \n', 'Calories not found');
            end
        else
            output = sprintf('%s \n', 'Calories not found');
        end
    else %Cal was not found in image
        output = sprintf('%s \n', 'Calories not found');
    end

    
end
