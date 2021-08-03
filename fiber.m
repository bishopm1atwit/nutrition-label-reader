function [output] = fiber(cellArrayText)
    %init output
    output = '';
    
    %fiber matches
    matches = ["fiber"; "dietary"];
    
    %extract cell containing fiber
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        fiber = cellArrayText{index};

        %split cell containing fiber into array by line
        C = splitlines(fiber);

        %find element within new array that contains fiber
        index = find(contains(C, matches));
        if size(index) > 0
            fiber = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            fiber = erase(fiber,pat);
            pat = digitsPattern(1) + ("%");
            fiber = erase(fiber,pat);
            
            %remove numbers after g
            pat = 'g *\d+ *';
            fiber = regexprep(fiber,pat,'');

            %if contains O instead of 0, replace with 0
            if(contains(fiber, "og") == 1)
                nums = "0";
            elseif contains(fiber, digitsPattern + "." + digitsPattern) == 1
                %extract numbers with decimal
                nums = regexp(fiber,'[0-9].[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            else
                %extract numbers
                nums = regexp(fiber,'[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            end

            fiber = 'Dietary Fiber';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'Dietary Fiber' with space between
                output = sprintf('%s%s', output, fiber);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else
                output = sprintf('%s%s \n', output, 'Dietary Fiber not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Dietary Fiber not found');
        end
    else %fiber was not found in image
        output = sprintf('%s%s \n', output, 'Dietary Fiber not found');
    end

end