function out = removeab(wv, V, abVec)

for k = 1:length(V)
    if length(abVec) < k
        break;
    end
    wv = wv - abVec(k)*V{k};
end

out = wv;