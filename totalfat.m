function [output] = totalfat(cellArrayText)
    %init output
    output = '';
    
    %total fat matches
    matches = ["tal f"; "tai f"];
    cellArrayText
    
    %extract cell containing total fat
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        fattext = cellArrayText{index};

        %split cell containing total fat into array by line
        C = splitlines(fattext);

        %find element within new array that contains total fat
        index = find(contains(C, matches));
        if size(index) > 0
            fattext = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            fattext = erase(fattext,pat);
            pat = digitsPattern(1) + ("%");
            fattext = erase(fattext,pat);

            %extract numbers - %TODO need to omit the last number found
            nums = regexp(fattext,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

            fattext = 'Total Fat';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'Calories' with space between
                output = sprintf('%s%s', output, fattext);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else 
                output = sprintf('%s%s \n', output, 'Total Fat not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Total Fat not found');
        end
    else %total fat was not found in image
        output = sprintf('%s%s \n', output, 'Total Fat not found');
    end

end