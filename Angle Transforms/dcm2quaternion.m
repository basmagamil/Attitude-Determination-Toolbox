function [qs, q] = dcm2quaternion(T)
%Converts from DCM to quaternion
%T is a 3x3 matrix
qss=sqrt((1+T(1,1)+T(2,2)+T(3,3))/4);
qxx=sqrt((1+T(1,1)-T(2,2)-T(3,3))/4);
qyy=sqrt((1-T(1,1)+T(2,2)-T(3,3))/4);
qzz=sqrt((1-T(1,1)-T(2,2)+T(3,3))/4);
qq_test=[qss qxx qyy qzz];
[m,i]=max(qq_test);
switch i
   case 1
      qs=qss;
      qx=(T(3,2)-T(2,3))/(4*qs);
      qy=(T(1,3)-T(3,1))/(4*qs);
      qz=(T(2,1)-T(1,2))/(4*qs);
   case 2
      qx=qxx;
      qs=(T(3,2)-T(2,3))/(4*qx);
      qy=(T(2,1)+T(1,2))/(4*qx);
      qz=(T(1,3)+T(3,1))/(4*qx);
   case 3
      qy=qyy;
      qs=(T(1,3)-T(3,1))/(4*qy);
      qx=(T(2,1)+T(1,2))/(4*qy);
      qz=(T(3,2)+T(2,3))/(4*qy);
   case 4
      qz=qzz;
      qs=(T(2,1)-T(1,2))/(4*qz);
      qx=(T(1,3)+T(3,1))/(4*qz);
      qy=(T(3,2)+T(2,3))/(4*qz);
end
q=[qx; qy; qz];
end
