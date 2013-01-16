function out = zerofind(xsc, ysc, order, start)

if nargin == 3
    start = .5;
elseif start <=0
    start = .001;
elseif start > 1
    start = 1;
end

p = polyfit(xsc,ysc,order);

strevl = '[out, fval, exitflag] = fsolve(@(x) ';
for k = 1:order + 1
    strevl = [strevl, num2str(p(end+1-k)) '*x.^', num2str(k-1),'+' ];
end
fnevl =  [strevl(1:end-1), ', xsc(ceil(length(xsc)*start)), optimset(''display'',''off''));'];   
eval(fnevl);

if exitflag ~= 1
    fprintf('WARNING: Exitflag = %d\n', exitflag);
end


