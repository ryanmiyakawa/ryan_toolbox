function formatted_out = s2f(in, sig)
if nargin == 1
    if in >= 60
        sig = 1;
    elseif in >= 30
        sig = .1;
    else
        sig = .01;
    end

end

daystr = '';
hourstr = '';
minstr = '';

if in >= 86400
    daystr = [num2str(floor(in/86400)) 'd '];
end
if in >= 3600
    hourstr = [num2str(floor(mod(in,86400)/3600)) 'h '];
end
if in >= 60
    minstr = [num2str(floor(mod(in,3600)/60)) 'm '];
end
secstr = [num2str(sround(mod(in,60), sig)) 's.'];

formatted_out = [daystr hourstr minstr secstr];