function [output] = protein(cellArrayText)
    %init output
    output = '';
    
    %protein matches
    matches = ["pro"; "tein"; "brat"];
    
    
    %extract cell containing protein
    index = find(contains(cellArrayText, matches));
    if size(index) > 0
        proteintext = cellArrayText{index};

        %split cell containing protein into array by line
        C = splitlines(proteintext);

        %find element within new array that contains protein
        index = find(contains(C, matches));
        if size(index) > 0
            proteintext = C{index};
            
            %remove percent daily value
            pat = digitsPattern(2) + ("%");
            proteintext = erase(proteintext,pat);
            pat = digitsPattern(1) + ("%");
            proteintext = erase(proteintext,pat);
            
            %remove numbers after g
            pat = 'g *\d+ *';
            proteintext = regexprep(proteintext,pat,'');

            %if contains O instead of 0, replace with 0
            if(contains(proteintext, "og") == 1)
                nums = "0";
            elseif contains(proteintext, digitsPattern + "." + digitsPattern) == 1
                %extract numbers with decimal
                nums = regexp(proteintext,'[0-9].[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            else
                %extract numbers
                nums = regexp(proteintext,'[0-9]','Match');
                nums = strjoin(nums);
                nums = strrep(nums,' ','');
            end

            proteintext = 'Protein';

            if(strlength(nums) ~= 0)
                %add string with numbers to title string 'protein' with space between
                output = sprintf('%s%s', output, proteintext);
                output = sprintf('%s %s%s \n', output, nums, 'g');
            else
                output = sprintf('%s%s \n', output, 'Protein not found');
            end
        else
            output = sprintf('%s%s \n', output, 'Protein not found');
        end
    else %total fat was not found in image
        output = sprintf('%s%s \n', output, 'Protein not found');
    end

end