function [output] = transfat(cellArrayText)
    %init output
    output = '';
    
    %protein matches
    matches = ["trans"];
    
    
    %extract cell containing protein
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        transfat = cellArrayText{index};

        %split cell containing trans fat into array by line
        C = splitlines(transfat);

        %find element within new array that contains trans fat
        index = find(contains(C, matches));
        if size(index) > 0
            transfat = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            transfat = erase(transfat,pat);
            pat = digitsPattern(1) + ("%");
            transfat = erase(transfat,pat);
            
            %remove numbers after g
            pat = 'g *\d+ *';
            transfat = regexprep(transfat,pat,'');

            %if contains O instead of 0, replace with 0
            if(contains(transfat, "og") == 1)
                nums = "0";
            elseif contains(transfat, digitsPattern + "." + digitsPattern) == 1
                %extract numbers with decimal
                nums = regexp(transfat,'[0-9].[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            else
                %extract numbers
                nums = regexp(transfat,'[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            end

            transfat = 'Trans Fat';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'Trans Fat' with space between
                output = sprintf('%s%s', output, transfat);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else
                output = sprintf('%s%s \n', output, 'Trans Fat not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Trans Fat not found');
        end
    else %trans fat was not found in image
        output = sprintf('%s%s \n', output, 'Trans Fat not found');
    end

end