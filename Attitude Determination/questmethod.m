function [Rbi] = questmethod(v1b,v1i,v2b,v2i)

Vb = [v1b v2b]; Vi = [v1i v2i];
n = 2;
w = n;
B = zeros(3,3);

for i = 1:n
    b = Vb(:,i)*Vi(:,i)';
    B = B + b;
end

%Setting up K
g = trace(B);
I = eye(3);
S = B + B';
K1 = S - g .* I;
Z = [B(2,3)-B(3,2) B(3,1)-B(1,3) B(1,2)-B(2,1)]';
K2 = Z;
K3 = Z';
K4 = g;
K = [K1 K2; K3 K4];

%Eigen K
y = sum(w);
P = ( (y + g) .* I - S) \ Z;
q = (1 ./ sqrt(1 + P' * P)) .* [P;1];
qs = q(4); qv = [q(1) q(2) q(3)];

%Setting up the DCM matrix
Rbi = quaternion2dcm_nonhomog(qs,qv);
end