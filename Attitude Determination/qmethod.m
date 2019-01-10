function [Rbi] = qmethod(v1b,v1i,v2b,v2i)
%v1i = [0.2673 0.5345 0.8018]';v2i = [-0.3124 0.9370 0.1562]';v1b = [0.7814 0.3751 0.4987]';v2b = [0.6163 0.7075 -0.3459]';
Vb = [v1b v2b]; Vi = [v1i v2i];
n = 2;
B = zeros(3,3);

for i = 1:n
    b = Vb(:,i) * Vi(:,i)';
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
[q,y] = eig(K);
q = q(:,length(q));
y = max(max(y));
qs = q(4); qv = [q(1) q(2) q(3)];

%Setting up the DCM matrix
Rbi = quaternion2dcm_nonhomog(qs,qv);
end