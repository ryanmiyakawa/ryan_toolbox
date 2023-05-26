function sheet_data = getGSheet(gID, sheet_name)


url_name = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',...
    gID, sheet_name);

sheet_data = table2cell(webread(url_name));


for i = 1:numel(sheet_data)
    value = sheet_data{i};
    
    if isnumeric(value) && isnan(value)
        sheet_data{i} = '';
    elseif isnumeric(value)
        sheet_data{i} = sprintf('<%g>', value);
    end
end
