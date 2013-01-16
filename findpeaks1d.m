function peaks = findpeaks1d(in, tol)
if nargin == 1
    tol = 10;
end
peaks = [];
img = abs(in);
av = mean(img(:));

idx = find(img > av);

for k = 1:length(idx)
    if biggestneighbor(img, idx(k), tol) 
        peaks = [peaks , idx(k) ]; %#ok<AGROW>
    end
end


function out = biggestneighbor(img, idx, tol)
len = length(img);
out = 0;
if (idx >= tol + 1 && idx <= len - tol && ...
        biggest(img(idx), img(idx-tol:idx+tol)))
    out = 1;
end

function out = biggest(val, in)
m = max(in(:));
out = (m == val);