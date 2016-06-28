% Map g in equation 28

function x = g(y,u,l)
    x = y.*(u-l)./2 + (u+l)./2;
end