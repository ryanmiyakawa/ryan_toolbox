% Like circshift, but does not wrap over

function out = circshiftc(mask, shftvec)
shftr = shftvec(1);
shftc = shftvec(2);
[sr,sc] = size(mask);
out = circshift(mask, [shftr, shftc]);

if abs(shftr) >= sr || abs(shftc) >= sc
    out = zeros(sr,sc);
    return
end
if shftr > 0
    out(1:shftr,:) = 0;
elseif shftr < 0
    out(sr+shftr+1:end,:) = 0;
end
if shftc > 0
    out(:,1:shftc) = 0;
elseif shftc < 0
    out(:,sc+shftc+1:end) = 0;
end