
% Phase function on a [-pi pi] domain

function z = unwrap2(abb_phase, wflag)

[rows,cols] = size(abb_phase);

mask = zeros(rows,cols);
temp = find(abb_phase ~= 0);
mask(temp) = 1;

if exist('wflag') == 1 && wflag == 'w'
    h = waitbar(0,'Unwrapping...');
    track = 1;
else
    track = 0;
end

% 1D unwrap each row
for i = 1:rows
    if track
        waitbar(.5*i/rows,h);
    end
    
    f(i,:) = unwrap(abb_phase(i,:));
end

f = f.*mask;


for i = 2:rows
    if track
        waitbar(.5+.5*i/rows,h);
    end
    % for each row and it's previous neighbor, find the columns of vertical
    % connectedness and store the elements of the current row and previous
    % row that are vertically connected in the vectors previous and
    % current, respectively, with a zero where the two rows are not
    % vertically connected.

    for j = 1:cols

        if mask(i,j) == 1 & mask(i-1,j) == 1
            previous(j) = f(i-1,j);
            current(j) = f(i,j);
            true(j) = 1;

        else
            previous(j) = 0;
            current(j) = 0;
            true(j) = 0;
        end

    end

    % Find the difference between neighboring rows in the vertically
    % connected domain then take the median of the nonzero difference
    % values to get the average difference

    delta(i,:) = current - previous;
    index = find(delta(i,:) ~=0);
    d(i) = median(delta(i,index));

    % If the average difference is larger than pi, shift all remaing rows
    % (below in the matrix) by 2*pi*sign(differnce)

    if abs(d(i)) > pi
        f(i:rows,:) = f(i:rows,:) - 2*pi*sign(d(i));
    else
    end

end

if track
    close(h); %closes waitbar
end

z = f;

function n = unwrap(phi)

N = length(phi);

for i = 1:N-1
    delta = phi(i+1) - phi(i);
    if abs(delta) > pi
        phi(i+1:N) = phi(i+1:N) - 2*pi*sign(delta);
    else
    end
end

n = phi;

