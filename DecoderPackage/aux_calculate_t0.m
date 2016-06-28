% find t0 in equation 30
%-------------------------
% Inputs: 
% y = output vector of the optimization
%     algorithm. All elements are in 
%     the range [-1,1]
% r = vector of reference, a feasible 
%     point in the feasible region
% u = maximum possible values of the 
%     feasible region
% l = minimum possible values of the 
%     feasible region

function t0 = aux_calculate_t0 ( y , r , l , u)

% find intersection of line with boundary 
ymax = max(abs(y));
s = aux_g ( y/ymax , u , l);

% parametrize the line in equation 26
t = sym('t');
line = (s-r) * t + r;

% constraints
c1 = aux_constraints(line);

% find feasible interval of line
tInterval = aux_IntervalFinder(c1,s,r);
nInterval = size(tInterval,1);

% euqation 29 
for i = 1:nInterval
    delta(i) = sum(tInterval(1:i,2)...
        -tInterval(1:i,1)) / ...
        sum ( tInterval(:,2) - tInterval(:,1) );
end
%
flag = 0;
for i = 1:nInterval
    if ymax <= delta(i) && flag == 0;
        j = i;
        flag = 1;
    end
end
% equation 30
if j>1
t0 = tInterval(j,1) + ( tInterval(j,2)...
    - tInterval(j,1) ) * ( ymax-delta(j-1) )...
    /(delta(j)-delta(j-1) );
else
    t0 = tInterval(j,1) + (tInterval(j,2)...
        - tInterval(j,1)) * (ymax) / (delta(j));
end
end

