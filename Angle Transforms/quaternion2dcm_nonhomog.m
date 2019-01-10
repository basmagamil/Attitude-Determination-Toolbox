function [T] = quaternion2dcm_nonhomog(qs,q)
%Converts from quaternion to DCM
%q is a 1x3 matrix
%T is a 3x3 matrix
qx=q(1); 
qy=q(2); 
qz=q(3);

T11=1-2*(qy^2+qz^2);
T12=2*(qx*qy+qz*qs);
T13=2*(qx*qz-qy*qs);

T21=2*(qy*qx-qz*qs);
T22=1-2*(qx^2+qz^2);
T23=2*(qy*qz+qx*qs);

T31=2*(qz*qx+qy*qs);
T32=2*(qz*qy-qx*qs);
T33=1-2*(qx^2+qy^2);

T=[T11,T12,T13;T21,T22,T23;T31,T32,T33];
end
