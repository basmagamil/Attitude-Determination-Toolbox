function [qs,q] = euler2quaternion(theta1,theta2,theta3,seq)
[T] = euler2dcm(theta1,theta2,theta3,seq);
[qs, q] = dcm2quaternion(T);
end
