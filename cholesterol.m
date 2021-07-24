function [output] = cholesterol(cellArrayText)
    %init output
    output = '';
    
    %cholesterol matches
    matches = ["chol"; "erol"];
    cellArrayText
    
    %extract cell containing cholesterol
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        choltext = cellArrayText{index};

        %split cell containing cholesterol into array by line
        C = splitlines(choltext);

        %find element within new array that contains cholesterol
        index = find(contains(C, matches));
        if size(index) > 0
            choltext = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            choltext = erase(choltext,pat);
            pat = digitsPattern(1) + ("%");
            choltext = erase(choltext,pat);

            %extract numbers
            nums = regexp(choltext,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

            choltext = 'Cholesterol';

            %add string with numbers to title string 'Cholesterol' with space between
            output = sprintf('%s%s', output, choltext);
            output = sprintf('%s %s%s \n', output, nums, 'mg');
        else
            output = sprintf('%s%s \n', output, 'Cholesterol not found');
        end
    else %total fat was not found in image
        output = sprintf('%s%s \n', output, 'Cholesterol not found');
    end

end