%filters input IN with 2D hanning window

function out = hanning2d(in, center, width)

[sr, sc] = size(in);
cr = center(1);
try
    cc = center(2);
catch
    error('CENTER MUST HAVE TWO COORDINATES')
end

han = zeros(sr,sc);
hw = floor(width/2);
idxr = cr - hw + 1 : cr + hw;
idxc = cc - hw + 1 : cc + hw;
[R C] = meshgrid(idxr-cr+hw, idxc - cc + hw);
han(idxr,idxc) = sin(pi*(R)/width).*sin(pi*(C)/width);

out = han.*in;


