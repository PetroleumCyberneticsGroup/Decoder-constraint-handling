% constraints as functions of optimization
% variables. Constraints here are from 
% example of the appendix

function out = aux_constraints(in1)

x1 = in1(:,1);
x2 = in1(:,2);
x3 = in1(:,3);
x4 = in1(:,4);

%% heel should lie inside the region
out(1) = 100^2 - x1.^2 - x2.^2;

%% toe should line inside the region
out(2) = 100^2- x3.^2 - x4.^2;
