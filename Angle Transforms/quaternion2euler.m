function [theta1,theta2,theta3] = quaternion2euler(qs,q,seq)

T=quaternion2dcm_nonhomog(qs,q);
[theta1,theta2,theta3] = dcm2euler(T,seq);

end
