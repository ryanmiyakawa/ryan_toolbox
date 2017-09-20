%6/23/11. Generates A.  Grace Gee

function mt=improved_generateA(al, be)
[n,m] = size(al);
[n2, m2] = size(be);

if (n~=n2) || (m~=m2)
    error('alpha and beta matrices must be the same size')
end

%a

al(n*m-n+1:end)=[];
f1=-al(:); %multiply in alpha
out= diag(sparse(f1), -n);

out=out-circshift(out, [n, 0]);
out = circshift(out, [-n,0]);
% f2=-al(:);
% c=zeros(n^2);
% c=c + diag(f2);
% c=circshift(c, [n, 0]);

%b
j1=sparse(-be(:));
u=spalloc(n*m, n*m, 2*n*m);
u=u+diag(j1);

betas=sparse(be(:));
b= diag(betas);
b=circshift(b,[1,0]);

b=b+diag(j1);

%b=[k b]

%b(:,n^2)=0;
b=circshift(b,[0,1]);
b(:,1:n:end)=0;
%k=zeros(n^2,1)

mt=[out b];

