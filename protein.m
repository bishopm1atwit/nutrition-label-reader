function [output] = protein(cellArrayText)
    %init output
    output = '';
    
    %protein matches
    matches = ["pro"; "tein"; "brat"];
    cellArrayText
    
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

            %extract numbers
            nums = regexp(proteintext,'[0-9]','Match');
            nums = strjoin(nums);
            nums = strrep(nums,' ','');

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