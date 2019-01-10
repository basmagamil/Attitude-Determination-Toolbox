function [R_b_s,s_body] = sun_sensor(alpha1,alpha2,qs,q)
% %%%inputs in radians
% alpha1=0.9501;
% alpha2=0.2311;
% %sun sensor frame with respect to the body frame as quaternion
% q=[0.1041; -0.2374; -0.5480];
% qs=0.7953;

%%sun sensor frame
s_sun_star=[1, tan(alpha1)/tan(alpha2), tan(alpha1)]';
S_star=sqrt(s_sun_star(1)^2+s_sun_star(2)^2+s_sun_star(3)^2); %magnitude
s_sun=s_sun_star/sqrt(s_sun_star'*s_sun_star);

%%Transformation
qx=[0,-q(3),q(2);q(3),0,-q(1);-q(2),q(1),0];
R_b_s=(qs^2-q'*q)*eye(3,3)+2*q*q'-2*qs*qx;
s_body=R_b_s*s_sun;
end

