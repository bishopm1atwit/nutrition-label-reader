function [output] = totalfat(cellArrayText)
    %init output
    output = '';
    
    %total fat matches
    matches = ["tal f"; "tai f"];
    
    
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
            
            %remove numbers after g
            pat = 'g *\d+ *';
            fattext = regexprep(fattext,pat,'');

            %if contains O instead of 0, replace with 0
            if(contains(fattext, "og") == 1)
                nums = "0";
            elseif contains(fattext, digitsPattern + "." + digitsPattern) == 1
                %extract numbers with decimal
                nums = regexp(fattext,'[0-9].[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            else
                %extract numbers - %TODO need to omit the last number found
                nums = regexp(fattext,'[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            end

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