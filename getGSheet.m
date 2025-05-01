function sheet_data = getGSheet(gID, sheet_ID)


url_name = sprintf('https://docs.google.com/spreadsheets/d/%s/export?format=csv&gid=%d', ...
    gID, sheet_ID);

opts = weboptions("ContentType", "text");
raw_csv = webread(url_name, opts);

lines = regexp(raw_csv, '\n', 'split')';
parsed = cellfun(@(line) strsplit(line, ','), lines, 'UniformOutput', false);

maxCols = max(cellfun(@numel, parsed));
for i = 1:numel(parsed)
    parsed{i}(end+1:maxCols) = {''};
end

sheet_data = vertcat(parsed{:});


% Sanitize: replace any "←" (left arrow) with empty string
% Clean all "←" from cells
for i = 1:numel(sheet_data)
    val = sheet_data{i};
    if ischar(val) || isstring(val)
        % Convert to string for Unicode-safe handling
        s = string(val);
        % If it contains U+2190 (←), replace it
        if contains(s, char(13))  
            s = replace(s, char(13), '');
        end
        sheet_data{i} = char(s);  % convert back to char if you want uniformity
    end
end
