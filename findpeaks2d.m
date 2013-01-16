function peaks = findpeaks2d(in, tol)

[m r c] = max2(in);

peaks = findpeaks1d(in(r,:),tol);
for k = 1:length(peaks)
    peaks(2,k) = peaks(1,k);
    peaks(1,k) = r;  
end

function [m r c] = max2(in)

[maxofcols rows] = max(in);
[m c] = max(maxofcols);
r = rows(c);