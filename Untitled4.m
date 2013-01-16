function out = extrude(in);

[sr,sc] = size(in);
[x,y] = meshgrid(in);

if sr == 1
    out = x;
elseif sc == 1
    out = y;
else
    error('ERROR: input must be a 1-D vector')
    