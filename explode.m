function out = explode(chr, ar, flag)
if nargin == 2
    flag = 's';
end

out = [];
for k = 1:length(ar)
    if k < length(ar)
        switch flag % convert number to str:
            case 'n'
                out = [out num2str(ar(k)) chr];
            case 'nc'
                out = [out num2str(ar{k}) chr];
            case 'c'
                out = [out ar{k} chr];
            otherwise
            out = [out ar(k) chr];
        end
        
    else
        switch flag % convert number to str:
            case 'n'
                out = [out num2str(ar(k)) ];
            case 'nc'
                out = [out num2str(ar{k}) ];
            case 'c'
                out = [out ar{k}];
            otherwise
            out = [out ar(k)];
        end
    end
end