function j= spinhole (D, s)

if nargin == 1
    s = 1;
end

%does not use pinhole function
%s place a 1 for (1/s) elements

r= ceil(D/2);
j= spalloc(D,D, ceil( ((pi *(D/2)^2)/s)));

j(round(s/2):s:end, round(s/2):s:end)= 1;
%combines two vectors of x and y coordinates
[x,y]= find(j);
ind=[x, y];
indx= ind;
% f= find (ind(  ((:,1)-r).^2 + ((:,2)-r).^2 > r^2));
ind= (     ((ind(:,1) -r).^2 + (ind(:,2)-r).^2)     ) > r^2 ;

f= find(ind);
% f=find (ind(( ind((1:length(ind)))-r).^2+(ind((length(ind))+1:end)-r).^2 > r^2));
j(  indx(f,1)+ (indx(f,2)-1)*D  )=0;


