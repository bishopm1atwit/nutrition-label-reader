function [output] = sodium(cellArrayText)
    %init output
    output = '';
    
    %sodium matches
    matches = ["sod"; "ium"];
    cellArrayText
    
    %extract cell containing sodium
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        sodiumtext = cellArrayText{index};

        %split cell containing sodium into array by line
        C = splitlines(sodiumtext);

        %find element within new array that contains sodium
        index = find(contains(C, matches));
        if size(index) > 0
            sodiumtext = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            sodiumtext = erase(sodiumtext,pat);
            pat = digitsPattern(1) + ("%");
            sodiumtext = erase(sodiumtext,pat);

            %extract numbers
            nums = regexp(sodiumtext,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

            sodiumtext = 'Sodium';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'sodium' with space between
                output = sprintf('%s%s', output, sodiumtext);
                output = sprintf('%s %s%s \n', output, nums, 'mg');
            else 
                output = sprintf('%s%s \n', output, 'Sodium not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Sodium not found');
        end
    else %total fat was not found in image
        output = sprintf('%s%s \n', output, 'Sodium not found');
    end

end