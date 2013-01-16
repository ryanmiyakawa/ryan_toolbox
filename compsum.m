%sum of a composite array
function out = compsum(comp)
out = 0;
for k = 1:length(comp)
    out = out + comp{k};
end