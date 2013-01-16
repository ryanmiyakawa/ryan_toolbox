function ch = getkey(m) 

% Determine the callback string to use
if nargin == 1,
    if strcmp(lower(m),'non-ascii'),
        callstr = ['set(gcbf,''Userdata'',get(gcbf,''Currentkey'')) ; uiresume '] ;
    else       
        error('Argument should be the string ''non-ascii''') ;
    end
else
    callstr = ['set(gcbf,''Userdata'',double(get(gcbf,''Currentcharacter''))) ; uiresume '] ;
end

% Set up the figure
% May be the position property  should be individually tweaked to avoid visibility
fh = figure('keypressfcn',callstr, ...
    'windowstyle','modal',...    
    'position',[0 0 1 1],...
    'Name','GETKEY', ...
    'userdata','timeout') ; 
try
    % Wait for something to happen
    uiwait ;
    ch = get(fh,'Userdata') ;
    if isempty(ch),
        ch = NaN ; 
    end
catch
    % Something went wrong, return and empty matrix.
    ch = [] ;
end

delete(fh) ;
