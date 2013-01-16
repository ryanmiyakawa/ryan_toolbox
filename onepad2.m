%pad2() pads a 2-D array with ones


function out = onepad2(x, numrows, numcols)
if nargin == 2
    numcols = numrows;
end
[sr sc] = size(x);


out = ones(numrows, numcols);
startr = ceil((numrows - sr)/2);
startc = ceil((numcols - sc)/2);

out(startr + 1: startr + sr, startc + 1: startc + sc) = x;


