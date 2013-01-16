function out = vrectblock(edgesize, rectwidth);

out = zeros(edgesize);
out(:, edgesize-rectwidth+1:end) = 1;
end
