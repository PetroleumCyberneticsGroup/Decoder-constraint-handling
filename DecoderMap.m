%% Decoder package
% Decoder maps the output of the
% optimization algorithm into the
% feasible region.
%--------------------------------
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
% constraints should be modified in 
% aux_constraints
%--------------------------------
% Output:
% fi = output of the decoder, a 
%      point in the feasible region

function fi = DecoderMap( y, r , u, l)
ymax = max(abs( y ));

% equation 30
if  sum (y) == 0
    fi = r;
else
    t0 = aux_calculate_t0 (y,r,l,u);
    fi=vpa ( r + t0 *(aux_g( y/ymax , u , l) - r));  
end
%
end
