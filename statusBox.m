function h = statusBox(txt)

h = msgBox(txt);
handles = get(h, 'children');
set(handles(2), 'visible', 'off');