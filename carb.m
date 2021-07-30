function [output] = carb(cellArrayText)
    %init output
    output = '';
    
    %carb matches
    matches = ["carb"; "hydrate"];
    cellArrayText
    
    %extract cell containing carb
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        carbtext = cellArrayText{index};

        %split cell containing carb into array by line
        C = splitlines(carbtext);

        %find element within new array that contains carb
        index = find(contains(C, matches));
        if size(index) > 0
            carbtext = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            carbtext = erase(carbtext,pat);
            pat = digitsPattern(1) + ("%");
            carbtext = erase(carbtext,pat);

            %extract numbers
            nums = regexp(carbtext,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

            carbtext = 'Total Carbohyrdrates';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'carb' with space between
                output = sprintf('%s%s', output, carbtext);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else
                output = sprintf('%s%s \n', output, 'Total Carbs not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Total Carbs not found');
        end
    else %total fat was not found in image
        output = sprintf('%s%s \n', output, 'Total Carbs not found');
    end

end