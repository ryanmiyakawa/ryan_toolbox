function out = normailze(in, flag)

if nargin == 1
    flag = 'max';
end



switch flag
    case 'max'
        out = in/max(abs(in(:)));
    case 'average'
        out = in/mean(in(:));
    case 'rms'
        out = in/std(in(:));
end


        