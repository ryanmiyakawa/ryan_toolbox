% 11/01/07 Custom progress bar
%
% Use as follows:
% h = waitbar(0,'Propagating...   0%  ETA: calculating...');
% t0 = clock;
% progress(<fraction of iterations done>, t0, h, <text>);

function [] = progress(percent_done, t0, waitbar_handle, text)



left = 1-percent_done;
elapsed = (etime(clock,t0));
timeleft = floor(left/(percent_done/elapsed));
hourstr = '';
minstr = '';
if timeleft >= 3600
    hourstr = [num2str(floor(timeleft/3600)) 'h '];
end
if timeleft >= 60
    minstr = [num2str(floor(mod(timeleft,3600)/60)) 'm '];
end
secstr = [num2str(mod(timeleft,60)) 's.'];


if percent_done > .1 || elapsed > 20
    waitbar(percent_done, waitbar_handle, [text ...
        num2str(floor(percent_done*100)) '%  ETA: ' hourstr minstr secstr  ] );
else
    waitbar(percent_done, waitbar_handle, [text ...
        num2str(floor(percent_done*100)) '%  ETA: calculating...' ] );
end