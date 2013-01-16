function [rcm, ccm] = cm(img)
[sr, sc] = size(img);
csum = sum(img);

csumweighted = csum.*(1:sc);
ccm = sum(csumweighted)/sum(csum);

rsum = sum(img, 2);
rsumweighted = rsum.'.*(1:sr);
rcm = sum(rsumweighted)/sum(rsum);

if nargout == 1 || nargout == 0
    rcm = [rcm, ccm];
end
   