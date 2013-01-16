function [] =  dispf(val, lp, rp)

if nargin == 1
    lp = 0;
    rp = 6;
end

if nargin == 2
    rp = lp;
    lp = 0;
end

str = ['%' num2str(lp) '.' num2str(rp) 'f\n'];
fprintf(str,val);



