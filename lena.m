function out = lena(in)

if nargin == 0 
    in = 512;
end


switch in
    case 256
        out = double(imread('lena256.png'));
    case 512
        out = double(imread('lena512.png'));
end

