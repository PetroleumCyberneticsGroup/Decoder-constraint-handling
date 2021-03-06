% find feasible interval of line L
function tInterval = aux_IntervalFinder (c1,s,r)

% first find the roots of c1
syms t real
c1_roots = [0;1];
v = 1; % root interval
% if constraints are polynomial, v = 1 also works

c=1;
for i=1:size(c1,2)
    c=c*c1(i);
end
for j = 0 : 1/v : 1-1/v
   for i = 1 : size(c1,2)
   a = vpasolve ( c1(i) , t , [j j+1/v] );
   c1_roots = union( a , c1_roots);
   end
end

% sort the roots
c1_roots = sort(c1_roots);
nroots = size(c1_roots,1);

% check all regions
% check epsilon before and after each point
% make the region 0=invalid, 1=feasible
% checkp=[0 1;...;1 1] 
% checkp(1,1)= first point before
% checkp(1,2) first roots after

checkp = zeros(nroots,2);
checkp(1,1) = 0;% we are looking for feasible region >0
%
for i = 2 : nroots
    if vpa(subs(c1,t,c1_roots(i)-eps)) >= 0
        checkp(i,1) = 1;
    end
end
checkp(nroots,2)=0;% we are looking for feasible region < 1
for i = 1:nroots-1
    if vpa(subs(c1,t,c1_roots(i)+eps)) >= 0 
    checkp(i,2) = 1;
    end
end
% primary interval
k = 0;
for i=1:nroots-1
    if checkp(i,2) == 1 && checkp(i+1,1) == 1
        k=k+1;
        pint(k,1:2) = [c1_roots(i) c1_roots(i+1)];
    end
end
% glue interval if possible: for example [1 2;2 3]
n = size(pint,1);
[t,p] = sort(pint(:));
z = cumsum(accumarray((1:2*n)',2*(p<=n)-1));
z1 = [0;z(1:end-1)];
A2 = [t(z1==0 & z>0),t(z1>0 & z==0)];
clear pint
tInterval = A2;
end

    
    
