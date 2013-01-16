%converts dots to underscores
function out = d2u(text)
out = text;
out(text == '.') = '_';