function sheet_data = gSheetToStructAr(gID, sheet_name)

url_name = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',...
    gID, sheet_name);

sheet_data = table2struct(webread(url_name));


