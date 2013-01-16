% function [m r c] = max2(in)

function [m r c] = max2(in)

[maxofcols rows] = max(in);
[m c] = max(maxofcols);
r = rows(c);

if nargout == 2
    r = [r c];
end
