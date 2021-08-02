function [output] = sugar(cellArrayText)
    %init output
    output = '';
    
    %sugar matches
    matches = ["sugar"; "sug"];
    
    %extract cell containing sugar
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        sugar = cellArrayText{index};

        %split cell containing sugar into array by line
        C = splitlines(sugar);

        %find element within new array that contains sugar
        index = find(contains(C, matches));
        if size(index) > 0
            sugar = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            sugar = erase(sugar,pat);
            pat = digitsPattern(1) + ("%");
            sugar = erase(sugar,pat);
            
            %remove numbers after g
            pat = 'g *\d+ *';
            sugar = regexprep(sugar,pat,'');

            %if contains O instead of 0, replace with 0
            if(contains(sugar, "og") == 1)
                nums = "0";
            else
                %extract numbers
                nums = regexp(sugar,'[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            end

            sugar = 'Sugar';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'Sugar' with space between
                output = sprintf('%s%s', output, sugar);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else
                output = sprintf('%s%s \n', output, 'Sugar not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Sugar not found');
        end
    else %sugar was not found in image
        output = sprintf('%s%s \n', output, 'Sugar not found');
    end

end