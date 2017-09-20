function [out p] = getFilesInDir(extensions, p)

if nargin == 0
    extensions = {'*'};
end
if nargin < 2
    p = uigetdir();
end
if ~iscell(extensions)
    fils = dir([p '/' extensions]);
    extensions = {'*'};
else
    fils = dir(p);
end


out = cell(0);
for k = 1:length(fils)
    thisName = fils(k).name;
    if (thisName(1) ~= '.' && thisName(end) ~= '~')
        splt = regexp(thisName, '\.', 'split');
        
        if extensions{1} == '*'
            out{length(out) + 1} = [p '/' thisName];
        else
            for m = 1:length(extensions)
                if strcmp(splt{end}, extensions{m})
                    out{length(out) + 1} = [p '/' thisName];
                end
                
            end
        end
        
    end
end
