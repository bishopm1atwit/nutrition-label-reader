function [output] = satfat(cellArrayText)
    %init output
    output = '';
    
    %saturated fat matches
    matches = ["sat"; "urated"];
    
    
    %extract cell containing saturated fat
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        satfat = cellArrayText{index};

        %split cell containing satfat into array by line
        C = splitlines(satfat);

        %find element within new array that contains saturated fat
        index = find(contains(C, matches));
        if size(index) > 0
            satfat = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            satfat = erase(satfat,pat);
            pat = digitsPattern(1) + ("%");
            satfat = erase(satfat,pat);
            
            %remove numbers after g
            pat = 'g *\d+ *';
            satfat = regexprep(satfat,pat,'');

            %if contains O instead of 0, replace with 0
            if(contains(satfat, "og") == 1)
                nums = "0";
            elseif contains(satfat, digitsPattern + "." + digitsPattern) == 1
                %extract numbers with decimal
                nums = regexp(satfat,'[0-9].[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            else
                %extract numbers
                nums = regexp(satfat,'[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            end

            satfat = 'Saturated Fat';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'Saturated Fat' with space between
                output = sprintf('%s%s', output, satfat);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else 
                output = sprintf('%s%s \n', output, 'Saturated Fat not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Saturated Fat not found');
        end
    else %sat fat was not found in image
        output = sprintf('%s%s \n', output, 'Saturated Fat not found');
    end

end